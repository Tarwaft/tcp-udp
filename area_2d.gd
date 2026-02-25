extends Area2D
@export var texture: Texture2D
@export var is_sender: bool = false
@export var datapack: PackedScene
@export var istcp:bool = true
@export var transmissiontimer: PackedScene
var hasverified = false
var sequence: int = 0

func _ready() -> void:
	#$TextureRect.texture = texture
	#$CollisionShape2D.shape.size = texture.get_size()
	if(istcp and is_sender):
		await get_tree().create_timer(0.1).timeout
		send(true,"SYN")
		


func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("datapack") and area.ownername != name):
		if istcp and not hasverified and not is_sender:
			hasverified = true
			send(false, "SYN_ACK")
		elif istcp and not hasverified:
			send(true, "ACK_RECEIVED")
			$Timer.start()
			hasverified = true
		elif !is_sender:
			send(false,"ACK",int(area.sequence))
		else:
			var timers = get_children()
			for t in timers:
				if(t.is_in_group("transmission")):
					if(str(t.seq) == str(area.sequence)):
						print("hi")
						t.queue_free()
		area.queue_free()
		pass

func _on_timer_timeout() -> void:
	if istcp and !hasverified:
		return
	if is_sender:
		sequence += 1
		send(true, " ", sequence)

func send(right:bool = true, text:String = "", seq:int = 0) -> void:
	var d: Area2D = datapack.instantiate()
	d.position = position
	d.ownername = name
	d.text = text
	d.go_right = right
	if(seq != 0):
		d.sequence = str(seq)
	if(text == " " and is_sender):
		var t = transmissiontimer.instantiate()
		t.seq = sequence
		add_child(t)
	
	
	get_parent().add_child(d)

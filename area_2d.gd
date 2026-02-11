extends Area2D
@export var texture: Texture2D
@export var is_sender: bool = false
@export var datapack: PackedScene
@export var istcp:bool = true
var hasverified = false

func _ready() -> void:
	$TextureRect.texture = texture
	$CollisionShape2D.shape.size = texture.get_size()
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
			await get_tree().create_timer(10).timeout
			hasverified = true
		area.queue_free()
		pass


func _on_timer_timeout() -> void:
	if istcp and !hasverified:
		return
	if is_sender:
		send()
		
func send(right:bool = true, text:String = "") -> void:
	var d: Area2D = datapack.instantiate()
	d.position = position
	d.ownername = name
	d.text = text
	d.go_right = right
	get_parent().add_child(d)

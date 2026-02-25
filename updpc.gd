extends Area2D
@export var datapack: PackedScene
@export var sending:bool = true
var hasverified = false
var sequence: int = 0

func _ready() -> void:
	#$TextureRect.texture = texture
	#$CollisionShape2D.shape.size = texture.get_size(
	pass




func _on_timer_timeout() -> void:
	if sending:
		send();

func send(right:bool = true, text:String = "", seq:int = 0) -> void:
	var d: Area2D = datapack.instantiate()
	d.position = position
	d.ownername = name
	d.text = text
	d.go_right = right
	if(seq != 0):
		d.sequence = str(seq)
	
	
	get_parent().add_child(d)


func _on_area_entered(area: Area2D) -> void:
	if area.ownername != name:
		area.free();

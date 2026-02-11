extends Area2D
@export var texture: Texture2D
@export var is_sender: bool = false
@export var datapack: PackedScene

func _ready() -> void:
	$TextureRect.texture = texture
	$CollisionShape2D.shape.size = texture.get_size()


func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("datapack") and area.name != name):
		#area.free()
		pass


func _on_timer_timeout() -> void:
	if is_sender:
		var d: Area2D = datapack.instantiate()
		d.position = position
		d.name = name
		get_parent().add_child(d)

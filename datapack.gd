extends Node2D
var speed = 400
var ownername
@export var go_right: bool = true
var text
var sequence:String
func _physics_process(delta: float) -> void:
	if text and $Label:
		$sequence.text = sequence
		$Label.text = text
	if go_right:
		position.x += speed * delta
	else:
		position.x -= speed * delta


func _on_mouse_entered() -> void:
	queue_free()

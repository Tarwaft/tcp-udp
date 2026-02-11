extends Node2D
var speed = 900
var ownername
@export var go_right: bool = true
var text
func _physics_process(delta: float) -> void:
	if text and $Label:
		$Label.text = text
	if go_right:
		position.x += speed * delta
	else:
		position.x -= speed * delta

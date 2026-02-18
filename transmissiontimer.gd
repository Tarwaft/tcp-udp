extends Timer
var seq
@export var data:PackedScene
func _on_timeout() -> void:
	get_parent().send(true, " ", int(seq))

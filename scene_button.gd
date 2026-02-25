extends Button

@export var other: String


func _on_pressed() -> void:
	var s = load(other)
	get_tree().change_scene_to_packed(s)

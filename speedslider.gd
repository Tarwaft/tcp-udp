extends HSlider

func _process(delta: float) -> void:
	Engine.time_scale = value;

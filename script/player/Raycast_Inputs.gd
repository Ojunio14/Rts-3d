extends Node3D
const RAY_LENGTH = 1000


signal mouseLeftClick



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseLeft"):
		emit_signal("mouseLeftClick")

func _process(delta: float) -> void:
	$"../Mouse_Area2D".position = get_viewport().get_mouse_position()
	pass

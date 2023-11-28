extends Node3D
class_name State
var Torre
signal  Transitioned


func _ready() -> void:
	Torre = get_parent().get_parent()

func Enter():
	
	pass

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	pass



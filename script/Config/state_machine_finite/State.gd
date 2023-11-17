extends Node3D
class_name State
var Player
signal  Transitioned
var is_runnig = false
var Current_Value
var direction : Vector3

func _ready() -> void:
	Player = get_tree().get_first_node_in_group("Player")

func Enter():
	
	pass

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	pass



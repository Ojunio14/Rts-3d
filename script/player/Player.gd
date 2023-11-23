extends Node3D
var path_balista : Array = [
		"res://assets/building/turret/balista/Baslista_LVL_1.glb"
		
		]




var is_selected_building = false
func _ready() -> void:
	get_node("Raycast_Inputs").mouseLeftClick.connect(sinal_Mouse_left_click)


func sinal_Mouse_left_click() -> void:
	is_selected_building = true
	pass


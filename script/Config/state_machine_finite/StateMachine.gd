extends Node3D
class_name StateMachine

@export var initial_state : State



var Current_State : Node3D

var history : Array = []
var states = {}

var dir : Vector3 = Vector3()

func _ready() -> void:
	if get_parent().name != "BALISTA_LVL_1" and get_parent().get_parent().is_in_group("group_Build"):
		for child in get_children():
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			if  child.name == "TowerSearching":
				#get_parent().get_node("Detected_Enemy").connect("body_entered",Callable(child,"_on_detected_enemy_body_entered"))
#				get_parent().get_node("Collision_Area_Building").connect("body_entered",Callable(child, "on_body_entered"))
				pass
			if child.name == "TowerAttacking":
#				get_parent().get_node("Detected_Enemy").connect("body_entered",Callable(child,"_on_detected_enemy_body_entered"))
#				get_parent().get_node("Detected_Enemy").connect("body_exited",Callable(child,"_on_detected_enemy_body_exited"))
#
				get_parent().get_node("Time_shoot").connect("timeout",Callable(child, "timeout"))
#				get_parent().get_node("Collision_Area_Building").connect("body_exited",Callable(child, "on_body_exited"))
			#get_child(0).Transitioned.connect(on_child_transition)
		
		if initial_state:
			initial_state.Enter()
			Current_State = initial_state
		
	#get_parent().get_node("Inputs").connect("sig_run",Callable(self, "run"))
	
	
func _process(delta: float) -> void:
	
				if Current_State:
					Current_State.Update(delta)

func _physics_process(delta: float) -> void:
				if Current_State:
					Current_State.Physics_Update(delta)

func on_child_transition(state,new_state_name):
	
	if state != Current_State:
		
		return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		
		return
	
	if Current_State:
		
		Current_State.Exit()
	
	new_state.Enter()
	Current_State = new_state



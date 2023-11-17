extends StaticBody3D
class_name Tower

#@onready var detected_enimies: Area3D = $detected_enimies
##/Ballista_tower_LVL_1_001
var ARROW : PackedScene = ResourceLoader.load("res://scene/Projectile/arrow.tscn")
var Trajectory = preload("res://script/Config/Trajectory.gd")


var can_fire = false
var target_atirar
var activeBuildingObject : bool
var objects : Array
var target = null


var Weapons : int = 0
var Life_Tower : float = 0

var launchPoint
var projectile
var launchSpeed = -5.0

enum StateTower {
	Searching,
	Atirar,
	Detected
}

var CurrentStateTower = StateTower.Searching

func Change_State(CurentState):
	match CurentState:
		StateTower.Searching:
			pass
		StateTower.Atirar:
			pass
			
			
			
			
#func on_body_entered(body):
#	if body.is_in_group("enimies"):
#		can_fire = true
#		target = body
#	pass
#
#func on_body_exited(body):
#
#
#	pass
#
func raycast(pos,target_):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(pos, target_)
	var result = space_state.intersect_ray(query)
	return result



func spawn(marker3D : Vector3,velocity : Vector3, gravity : Vector3):
	var obj = ARROW.instantiate()
	obj.velocity = velocity
	obj.gravity = gravity
	get_tree().get_first_node_in_group("Projectile_group").add_child(obj)
	obj.global_transform.origin = marker3D
	
func chama (Player,speed,target,_target_velocity):
	var pos = Trajectory.intercept_position($Player.global_transform.origin, $UI/Views/ProjectileSpeedHSlider.value, $Target.global_transform.origin, _target_velocity)
	
	if not pos:
		print("--------if")
		
	else:
		print("--------else")
		#spawn($Player.global_transform.origin.direction_to(pos) * $UI/Views/ProjectileSpeedHSlider.value, Vector3.ZERO)



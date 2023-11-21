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
var ProjectileArrowSpeed : float = 10.0

enum StateTower {
	Searching,
	Atirar,
	Detected
}




	

			
			
			
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



func spawn(marker3D ,velocity : Vector3, gravity : Vector3):
	var obj = ARROW.instantiate()
	obj.velocity = velocity
	obj.gravity = gravity
	
	get_tree().get_first_node_in_group("Projectile_group").add_child(obj)
	obj.global_rotation = marker3D.global_rotation
	obj.global_transform.origin = marker3D.global_transform.origin
	
func Intercept_trajectory (_Dictionary : Dictionary):
	var Player = _Dictionary["Marker"]
	var speed = _Dictionary["Speed"]
	var target = _Dictionary["Pos_Target"]
	var _target_velocity = _Dictionary["_target_velocity"]
	var Marker = _Dictionary["Marker"]
	var pos = Trajectory.intercept_position(Player.global_transform.origin, speed, target, _target_velocity)
	
	if not pos:
		print(pos)
		
	else:
		
		spawn(Marker,Player.global_transform.origin.direction_to(pos) * speed, Vector3.ZERO)



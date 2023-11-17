extends StaticBody3D
class_name Tower

#@onready var detected_enimies: Area3D = $detected_enimies
##/Ballista_tower_LVL_1_001
var ARROW : PackedScene = ResourceLoader.load("res://scene/Projectile/arrow.tscn")



var can_fire = false
var target_atirar
var activeBuildingObject : bool
var objects : Array
var target = null


var Weapons : int = 0
var Life_Tower : float = 0

var launchPoint
var projectile
var launchSpeed = 5.0

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
func spawn():
	var obj = ARROW.instantiate()
	obj.transform = $Marker3D.transform
	get_tree().get_first_node_in_group("Projectile_group").add_child(obj)
	obj.global_position = $Marker3D.global_position
	obj.global_rotation = $Marker3D.global_rotation
	obj.set_linear_velocity($Marker3D.global_position * launchSpeed)

extends StaticBody3D
class_name Tower

#@onready var detected_enimies: Area3D = $detected_enimies
##/Ballista_tower_LVL_1_001
var ARROW : PackedScene = ResourceLoader.load("res://scene/Projectile/arrow.tscn")


var Trajectory = preload("res://script/Config/Trajectory.gd")




var activeBuildingObject : bool


#------------------------------Informaçoes sobre a Torre-------------------------------------------
var Weapons : int = 0
var Life_Tower : float = 0

var ProjectileArrowSpeed : float = 50.0
var Projectile_Arrow_Speed_Auto : float = 15.0
var Projectile_Arrow_Speed_Manual : float = 20.0

enum StateTower {
	Searching,
	Attacking,
	Detected
}

var objects : Array = []
func raycast(pos,target_):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(pos, target_)
	var result = space_state.intersect_ray(query)
	return result

func RayCastMouse(type):
	var spaceState = get_world_3d().direct_space_state
	var MousePos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var RayOrigin = camera.project_ray_origin(MousePos)
	var RayEnd = RayOrigin + camera.project_ray_normal(MousePos) *2000
	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd))
	if not rayArray.is_empty():
		if type == 0:
			return rayArray
#			if rayArray["collider"].name != "Player":
#				if rayArray.has("position"):
#					pass
		elif type == 1:

			if rayArray["collider"].name != "Player":
				if rayArray.has("position"):
					return rayArray["position"]




#------------------------------Funçoes para calculor da trajetoria do projectile-------------------------------------------

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



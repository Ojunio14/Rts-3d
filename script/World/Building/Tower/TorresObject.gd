extends "res://script/Config/Classe/Classe_Tower.gd"

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var collision_area_building: Area3D = $"../Collision_Area_Building"
@onready var detected_enimies: Area3D = $detected_enimies
#/Ballista_tower_LVL_1_001
var time: Timer
@onready var torre: Node3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre
@onready var spawn_projectile_marker: Marker3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre/spawn_projectile_marker

@onready var time_shoot: Timer = $Time_shoot



var _target_prev_pos #$Target.global_transform.origin
var _target_velocity = Vector3.ZERO

var TimeAttacking : bool = false

var TARGET = null

var CurrentStateTower = Searching


var is_attacking : bool = false

enum {
	Searching,
	Attacking
	
	
	
}

var Intercept_Dictionary : Dictionary = {
	"Pos_Initial" : Vector3(),
	"Speed" : ProjectileArrowSpeed,
	"Pos_Target" : Vector3(),
	"_target_velocity" : _target_velocity,
	"Marker" : Object
	
}


func _ready() -> void:
	detected_enimies.body_entered.connect(on_body_entered)
	detected_enimies.body_exited.connect(on_body_exited)
	time_shoot.timeout.connect(timeout)
	
	Intercept_Dictionary["Marker"] = spawn_projectile_marker
	
	$Collision_Area_Building.connect("area_entered",Callable(self, "on_area_entered"))
	$Collision_Area_Building.connect("area_exited",Callable(self, "on_area_exited"))
	

func _process(_delta: float) -> void:
#	if self.name != "BALISTA_LVL_1":
#		if can_fire:
#			var vec3 =TARGET.global_position
#			var cast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
#			#print(cast["position"])
#			#point = cast["position"] - 
#			torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y
#
#	if Input.is_action_just_pressed("destroy"):
#
#		var pos_initial = spawn_projectile_marker.global_transform.origin
#		if TARGET != null:
#			var vec3 =TARGET.global_position
#			var cast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
#			var pos_target = cast["position"]
#			#pos_target = Vector3(pos_target.x,pos_target.y + 0.5,pos_target.z)
#			Intercept_trajectory(spawn_projectile_marker,ProjectileArrowSpeed,pos_target,_target_velocity,spawn_projectile_marker)
#			#spawn(spawn_projectile_marker,point,delta,gravity)
#
			pass
		
		

func _physics_process(_delta) -> void:
#	if TARGET != null:


	#Change_State(CurrentStateTower,delta)

	pass


	

func set_State_Tower(Current) -> void:
	match Current:
		Searching:
			CurrentStateTower = Searching
			pass
		Attacking:
			CurrentStateTower = Attacking
			
			pass




func Change_State(CurentState,delta):
	match CurentState:
		Searching:
			pass
		Attacking:
			_Func_State_Attacking(delta)


func _Func_State_Attacking(delta) -> void:
	_target_velocity = (TARGET.global_transform.origin - _target_prev_pos) / delta
	_target_prev_pos = TARGET.global_transform.origin

	var vec3 = TARGET.global_position
	torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y

	if not is_attacking:
		time_shoot.start()
		is_attacking = true
	

func on_body_entered(body):
	if body.is_in_group("enimies"):
		#set_State_Tower(Attacking)
		TARGET = body
		_target_prev_pos = body.global_transform.origin



func on_body_exited(body):
	if body.is_in_group("enimies"):
		set_State_Tower(Searching)
	
	pass

func on_area_entered(area):
	if area.name == "Collision_Area_Building":
		if activeBuildingObject:
			BuildManager.AbleBuilding = false
			objects.append(area)
	


func on_area_exited(area):
	if area.name == "Collision_Area_Building":
		if activeBuildingObject:
			objects.remove_at(objects.find(area))
			if objects.size() <= 0:
				BuildManager.AbleBuilding = true
	



func Detected_State():
	pass

func timeout() -> void:
#	var vec3 = TARGET.global_position
#	var cast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
#
#	var c = cast["position"]
#	Intercept_Dictionary["Pos_Target"] = Vector3(c.x,c.y + 0.1,c.z)#cast["position"]
#	Intercept_Dictionary["_target_velocity"] = _target_velocity
#	Intercept_trajectory(Intercept_Dictionary)
#	is_attacking = false
#
	pass

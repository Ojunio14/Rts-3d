extends "res://script/Config/Classe/Classe_Tower.gd"

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var detected_enimies: Area3D = $detected_enimies
#/Ballista_tower_LVL_1_001

@onready var torre: Node3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre
@onready var spawn_projectile_marker: Marker3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre/spawn_projectile_marker
var point
var _target_prev_pos #$Target.global_transform.origin
@onready var _target_velocity = Vector3.ZERO

var target_in_area : bool = false

func _ready() -> void:
	detected_enimies.body_entered.connect(on_body_entered)
	detected_enimies.body_exited.connect(on_body_exited)
	
	$Collision_Area_Building.connect("area_entered",Callable(self, "on_area_entered"))
	$Collision_Area_Building.connect("area_exited",Callable(self, "on_area_exited"))


func _process(delta: float) -> void:
	if self.name != "BALISTA_LVL_1":
		if can_fire:
			var vec3 =target.global_position
			var cast = raycast(spawn_projectile_marker.global_position,target.global_position)
			#print(cast["position"])
			point = cast["position"] - spawn_projectile_marker.global_position
			torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y
			
	if Input.is_action_just_pressed("destroy"):

		
		#spawn(spawn_projectile_marker,point,delta,gravity)
		pass
		
		
		

func _physics_process(delta) -> void:
	_target_velocity = ($Target.global_transform.origin - _target_prev_pos) / delta
	_target_prev_pos = $Target.global_transform.origin
	
	Change_State(CurrentStateTower)


func on_body_entered(body):
	if body.is_in_group("enimies"):
		CurrentStateTower = StateTower.Detected
		
		
		
		
		
		
		
		
		
		
		
		target_in_area = true
		can_fire = true
		target = body
		_target_prev_pos = body.global_transform.origin
	pass

func on_body_exited(body):
	
	
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

extends Node3D




var BALISTA_TOWER : PackedScene = ResourceLoader.load("res://scene/scene_world/build/turret/balista/balista_lvl_1.tscn")#ResourceLoader.load("res://scene/scene_world/build/turret/balista/balista_lvl_1.tscn")
var WIZARD_TOWER : PackedScene = ResourceLoader.load("res://scene/scene_world/build/turret/Wizard/Wizard_lvl_1.tscn")

var Buildind_no_chao = false
var CurrentSpawnable : StaticBody3D
var AbleBuilding : bool = true



func _physics_process(delta: float) -> void:
	
	if GameManager.CurrentState == GameManager.State.Buildling:
		
		var camera = get_viewport().get_camera_3d()
		var from = camera.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		#print(vec3.get_object().position)
		var vec3 = cursorPos
		if vec3 != null:
			CurrentSpawnable.global_position = Vector3(round(vec3.x),vec3.y,round(vec3.z))#Vector3(vec3.x,0,vec3.z)
			CurrentSpawnable.activeBuildingObject = true
		#print(vec3)
		
		if AbleBuilding:
			#get_tree().root.get_node("Main/teste1").global_position = cursorPos#
			#print(Vector3(round(vec3.x),0,round(vec3.z)))
			
			if Input.is_action_just_pressed("destroy"):
				CurrentSpawnable.queue_free()
				GameManager.CurrentState = GameManager.State.Play
			
			if Input.is_action_just_pressed("MouseLeft") :
				var obj := CurrentSpawnable.duplicate()
				
				get_tree().root.get_node("Scene_Main/Build").add_child(obj)
				obj.activeBuildingObject = false
				obj.global_position = CurrentSpawnable.global_position
				

func Spawn_Balista_tower() -> void:
	SpawnOBj(BALISTA_TOWER)
func Spawn_Wizard_tower() -> void:
	SpawnOBj(WIZARD_TOWER)



func SpawnOBj(obj):
	if CurrentSpawnable != null:
		CurrentSpawnable.queue_free()
	CurrentSpawnable = obj.instantiate()
	get_tree().root.get_node("Scene_Main/Build").add_child(CurrentSpawnable)
	GameManager.CurrentState = GameManager.State.Buildling
	





func RaycastMouse(type):


	
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 1000#RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	#query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	if not result.is_empty():
		if type == 0:
			
			return result["position"]
		
		
func mouse():
	#var space_state = get_world_3d().direct_space_state
	var camera = get_viewport().get_camera_3d()
	var from = camera.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + camera.project_ray_normal(get_viewport().get_mouse_position())
	var Cursopos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from,to)
#	var query = PhysicsRayQueryParameters3D.create(from, to)
#	var result = space_state.intersect_ray(query)
	
	return Cursopos

#	var space_state = get_world_3d().direct_space_state
#	var cam = get_viewport().get_camera_3d()
#	var mousepos = get_viewport().get_mouse_position()
#
#	var origin = cam.project_ray_origin(mousepos)
#	var end = origin + cam.project_ray_normal(mousepos) * 1000#RAY_LENGTH
#	var query = PhysicsRayQueryParameters3D.create(origin, end)

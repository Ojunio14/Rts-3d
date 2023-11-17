extends Node3D


@onready var spawn_projectile_marker: Marker3D = $"../Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre/spawn_projectile_marker"




@onready var gizmo_y: MeshInstance3D = $GizmoY
@onready var gizmo_floor: MeshInstance3D = $Gizmo_floor

#@onready var marker_3d: Marker3D = $"../Marker3D"

func  _ready() -> void:
	#get_parent().draw_lines_target.connect(Draw_and_Moviment)
	call_deferred("_init_mouse_line")




func Draw_and_Moviment() -> void:
	var enimies = get_tree().get_first_node_in_group("enimies")
	var result = raycast(spawn_projectile_marker.global_position, enimies.global_position)
	
	if result["collider"].name == "floor":
		_update_mouse_line(spawn_projectile_marker.global_position)
		movement_gizmo(0)
		#Mouse_Vec transform.origin.y,

		
	if not result["collider"].name == "floor":
		#Vector3(gizmo_position.x,gizmo_position,gizmo_position.z)#Mouse_Vec transform.origin.y,
		_update_mouse_line(spawn_projectile_marker.global_position)

		movement_gizmo(1)

func movement_gizmo(type):
	var enimies = get_tree().get_first_node_in_group("enimies")
	var result = raycast(spawn_projectile_marker.global_position, enimies.global_position)
	result = result["position"]
	if type == 0:
#		if result["collider"].name = "floor":
			
		gizmo_y.visible = false
		gizmo_floor.global_position = Vector3(result.x,0,result.z)
			
	elif type == 1:
		var vec3 = Vector3(result.x,0,result.z)
		line_horizontal(vec3)
		gizmo_y.visible = true
		gizmo_floor.global_position = vec3
		gizmo_y.global_position = result
		
		
		
		pass

func raycast(pos,target_):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(pos, target_)
	var result = space_state.intersect_ray(query)
	return result


#func RayCastMouse(type):
#	var spaceState = get_world_3d().direct_space_state
#	var MousePos = get_viewport().get_mouse_position()
#	var camera = get_viewport().get_camera_3d()
#	var RayOrigin = camera.project_ray_origin(MousePos)
#	var RayEnd = RayOrigin + camera.project_ray_normal(MousePos) *2000
#	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd))
#
#	if not rayArray.is_empty():
#		if type == 0:
#			return rayArray
##			if rayArray["collider"].name != "Player":
##				if rayArray.has("position"):
##					pass
#		elif type == 1:
#
#			if rayArray["collider"].name != "Player":
#				if rayArray.has("position"):
#					return rayArray["position"]
#


#@onready var spawn_projectile_marker: Marker3D = $"../canhao/base/Base_Default_0/Head_Default_0/Spawn_Projectile_Marker"



#@onready var spawn_projectile_marker: Marker3D = $"../Morteiro/Node3D/Group_Marker/Spawn_Projectile_Marker"



var points:Array
var lines:Array

var mouse_line: MeshInstance3D
var mouse_line2: MeshInstance3D


	
	
func _process(_delta: float) -> void:
	Draw_and_Moviment()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_cam"):
		_draw_point_and_line()
		pass
	if event.is_action_pressed("move_cam"):
		_clear_points_and_lines()
		pass
#Returns the position in 3d that the mouse is hovering, or null if it isnt hovering anything
func get_mouse_pos():
	var space_state = get_parent().get_world_3d().get_direct_space_state()
	var mouse_position = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 1000
		
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	params.collision_mask = 1
	params.exclude = []
	
	var rayDic = space_state.intersect_ray(params)	
	
	if rayDic.has("position"):
		return rayDic["position"]
	return null

func _init_mouse_line():
	#await _init_mouse_line()
	#return _init_mouse_line()
	mouse_line = line(Vector3.ZERO, Vector3.ZERO, Color.BLACK)
	mouse_line2 = line(Vector3.ZERO, Vector3.ZERO, Color.BLACK)
	pass
		
func _update_mouse_line(vari):

	var enimies = get_tree().get_first_node_in_group("enimies")
	var result = raycast(spawn_projectile_marker.global_position, enimies.global_position)
	
	var mouse_pos = result["position"]


	var material := ORMMaterial3D.new()
	var mouse_line_immediate_mesh = mouse_line.mesh as ImmediateMesh
	if mouse_pos != null:
		#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = Color.WEB_GREEN
		#mouse_line_immediate_mesh.surface_set_color(Color.WEB_GREEN)
		
		var mouse_pos_V3:Vector3 = mouse_pos
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(vari)
		mouse_line_immediate_mesh.surface_add_vertex(mouse_pos_V3)
		mouse_line_immediate_mesh.surface_end()
		#mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES,)
		#mouse_line_immediate_mesh.	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		#material.albedo_color = color
func  line_horizontal(vari):
	var enimies = get_tree().get_first_node_in_group("enimies")
	var result = raycast(spawn_projectile_marker.global_position, enimies.global_position)
	
	var mouse_pos = result["position"]
	var material := ORMMaterial3D.new()
	var mouse_line_immediate_mesh = mouse_line2.mesh as ImmediateMesh
	if mouse_pos != null:
		#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = Color.WEB_GREEN
		#mouse_line_immediate_mesh.surface_set_color(Color.WEB_GREEN)
		
		var mouse_pos_V3:Vector3 = mouse_pos
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(vari)
		mouse_line_immediate_mesh.surface_add_vertex(mouse_pos_V3)
		mouse_line_immediate_mesh.surface_end()

func _draw_point_and_line()->void:
	var enimies = get_tree().get_first_node_in_group("enimies")
	var result = raycast(spawn_projectile_marker.global_position, enimies.global_position)
	
	var mouse_pos = result["position"]
	if mouse_pos != null:
		var mouse_pos_V3:Vector3 = mouse_pos
		#points.append(point(mouse_pos_V3,0.05))
		
		#If there are at least 2 points...
		if points.size() > 1:
			#Draw a line from the position of the last point placed to the position of the second to last point placed
			var point1 = points[points.size()-1]
			var point2 = points[points.size()-2]
			#var line = line(point1.position, point2.position)
			lines.append(line)

func _clear_points_and_lines()->void:
	for p in points:
		p.queue_free()
	points.clear()
		
	for l in lines:
		l.queue_free()
	lines.clear()




func line(pos1: Vector3, pos2: Vector3, color = Color.WEB_GREEN, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	get_tree().get_root().add_child(mesh_instance)
	if persist_ms:
		#await get_tree().create_timer()
		#await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


func point(pos:Vector3, radius = 0.05, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
		
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	sphere_mesh.material = material
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	get_tree().get_root().add_child(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance

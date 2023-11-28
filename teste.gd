extends Node3D

#------------------------------Onready-------------------------------------------
@onready var spawn_projectile_marker: Marker3D = $"../spawn_projectile_marker"
@onready var gizmo_y: MeshInstance3D = $GizmoY
@onready var gizmo_floor: MeshInstance3D = $Gizmo_floor

#@onready var marker_3d: Marker3D = $"../Marker3D"

var points:Array
var lines:Array

var mouse_line: MeshInstance3D
var mouse_line2: MeshInstance3D


#vai receber o Object dos enimies
var enimies : Object = null
var result = null
func  _ready() -> void:
	#get_parent().draw_lines_target.connect(Draw_and_Moviment)
	call_deferred("_init_mouse_line")
		
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("move_cam"):
#		if GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.manual:
#			_draw_point_and_line()
#
#
#	if event.is_action_pressed("move_cam"):
#
#		if GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.manual:
#
#			_clear_points_and_lines()

func _process(_delta: float) -> void:

	match GameManager.Current_State_Tower:
		GameManager.Estado_para_Atirar.manual:
			Desenha_Linha_Com_Gizmos(0)
		GameManager.Estado_para_Atirar.automatico:
			if get_parent().lista_alvos != []:
				if get_parent().lista_alvos[0] != null:
					enimies = get_parent().lista_alvos[0]
					Desenha_Linha_Com_Gizmos(1)


#------------------------------Onready-------------------------------------------
#vai chama a funçao a para desenha linhas e a fuçao de movimentaçao dos gizmo
func Desenha_Linha_Com_Gizmos(tipo_ray_cast) -> void:
#==================================================
#	Esse trecho vai decidir qual Raycast Usar
	if tipo_ray_cast == 0:
		result = RayCastMouse(0)
	elif tipo_ray_cast == 1:
		if enimies != null:
			result = RayCast(spawn_projectile_marker.global_position, get_parent().lista_alvos[0].global_position)
		else:
			result = null

	if result != null:
		if result["collider"].name == "floor":
			_update_mouse_line(spawn_projectile_marker.global_position)
			movement_gizmo(0,tipo_ray_cast)

		if not result["collider"].name == "floor":
			#Vector3(gizmo_position.x,gizmo_position,gizmo_position.z)#Mouse_Vec transform.origin.y,
			_update_mouse_line(spawn_projectile_marker.global_position)
			movement_gizmo(1,tipo_ray_cast)

#funçao para movimenta os gizmos
func movement_gizmo(type,type_ray_cast : int):

	var vec3
	match type_ray_cast:
		0:
			result = RayCastMouse(0)
			vec3 = result["position"]
		1:
			result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
			vec3  = result["position"]

	if type == 0:
#	Movimenta so o gizmo azul
		gizmo_y.visible = false
		gizmo_floor.global_position = Vector3(vec3.x,0,vec3.z)
		$MeshInstance3D.global_position = Vector3(vec3.x,1,vec3.z)
		
		
	elif type == 1:
#		movimenta os dois gizmos
		line_horizontal(Vector3(vec3.x,0,vec3.z))
		gizmo_y.visible = true
		gizmo_floor.global_position = Vector3(vec3.x,0,vec3.z)
		$MeshInstance3D.global_position = Vector3(vec3.x,1,vec3.z)
		gizmo_y.global_position = Vector3(vec3.x, vec3.y + 0.3 , vec3.z)#
		

#------------------------------RayCast-------------------------------------------

func RayCast(pos,target_):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(pos, target_)
	var result = space_state.intersect_ray(query)
	return result

#RayCast para Mouse personalizado
func RayCastMouse(type):
	var spaceState = get_world_3d().direct_space_state
	var MousePos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	
	var RayOrigin = camera.project_ray_origin(MousePos)
	var RayEnd = RayOrigin + camera.project_ray_normal(MousePos) *2000
	
	var query = PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd)
	#query.exclude = [get_tree()]
	var rayArray = spaceState.intersect_ray(query)
	
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



#Returns the position in 3d that the mouse is hovering, or null if it isnt hovering anything
func RayCastMouse2():
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

#------------------------------Funçoes para desenha lines-------------------------------------------

func _init_mouse_line():
	#await _init_mouse_line()
	#return _init_mouse_line()
	mouse_line = line(Vector3.ZERO, Vector3.ZERO, Color.BLACK)
	mouse_line2 = line(Vector3.ZERO, Vector3.ZERO, Color.BLACK)

func _update_mouse_line(vari):
	match GameManager.Current_State_Tower:
		0:
			result = RayCastMouse(0)
			
		1:
			result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
			
	#result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
	var material := ORMMaterial3D.new()
	var mouse_line_immediate_mesh = mouse_line.mesh as ImmediateMesh
	if result["position"] != null:
		#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = Color.WEB_GREEN
		#mouse_line_immediate_mesh.surface_set_color(Color.WEB_GREEN)
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(vari)
		mouse_line_immediate_mesh.surface_add_vertex(result["position"])
		mouse_line_immediate_mesh.surface_end()
		#mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES,)
		#mouse_line_immediate_mesh.	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		#material.albedo_color = color

func  line_horizontal(vari):
	#result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)


	match GameManager.Current_State_Tower:
		0:
			result = RayCastMouse(0)
			
		1:
			result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
			

	
	var material := ORMMaterial3D.new()
	var mouse_line_immediate_mesh = mouse_line2.mesh as ImmediateMesh
	if result["position"] != null:
		#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = Color.WEB_GREEN
		#mouse_line_immediate_mesh.surface_set_color(Color.WEB_GREEN)
		
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(vari)
		mouse_line_immediate_mesh.surface_add_vertex(result["position"])
		mouse_line_immediate_mesh.surface_end()

func _draw_point_and_line()->void:
	#result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
	
	match GameManager.Current_State_Tower:
		0:
			result = RayCastMouse(0)
			
		1:
			result = RayCast(spawn_projectile_marker.global_position, enimies.global_position)
			
	
	if result["position"] != null:
#		var mouse_pos_V3:Vector3 = mouse_pos
		#points.append(point(mouse_pos_V3,0.05))
		
		#If there are at least 2 points...
		if points.size() > 1:
			#Draw a line from the position of the last point placed to the position of the second to last point placed
#			var point1 = points[points.size()-1]
#			var point2 = points[points.size()-2]
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

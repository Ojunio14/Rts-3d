extends State
class_name RunPlayer

var camera_3d 


	
func Enter():
	
	camera_3d  = get_viewport().get_camera_3d()
	
	
	pass

func Update(delta : float):
	
	if Input.is_action_just_released("shift") :
		if Player.input_dir != Vector2.ZERO:
			Transitioned.emit(self,"WalkPlayer")
		else:
			if Player.input_dir == Vector2.ZERO:
				Transitioned.emit(self,"IdlePlayer")
	
	if  Player.input_dir != Vector2.ZERO:
		#Transitioned.emit(self,"Walk")
		pass

	elif Player.input_dir == Vector2.ZERO:
		#print(direction,"runnnnn")
		Transitioned.emit(self,"IdlePlayer")
		pass



func Physics_Update(delta : float):
	
	Player.Selected_Animation_Player(Player.Walk,Player.Run,Player.animation_tree)
	direction = (transform.basis * Vector3(Player.input_dir.x, 0, Player.input_dir.y)).normalized()
	
	var get_angle_camera = camera_3d.transform.basis.get_euler().y
	var new_direction = Quaternion.from_euler(Vector3(0,get_angle_camera,0)) * direction

	
	Player.get_node("Body_Player").rotation.y = lerp_angle(Player.get_node("Body_Player").rotation.y, atan2(  -new_direction.x , -new_direction.z), delta *  3.5)
	direction = new_direction
		#moviment_player = 
	Player.velocity.x = direction.x * Player.SPEED_RUN
	Player.velocity.z = direction.z * Player.SPEED_RUN

	pass
	#if not Aim:


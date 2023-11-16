extends State
class_name JumpPlayer



var camera_3d 

func Enter():
	camera_3d  = get_viewport().get_camera_3d()
	Player.velocity.y = Player.JUMP_VELOCITY
	pass

func Update(delta : float):
	if Player.is_on_floor():
		if Player.input_dir == Vector2.ZERO:
			Transitioned.emit(self,"IdlePlayer")
		elif Player.input_dir != Vector2.ZERO:
			Transitioned.emit(self, "WalkPlayer")


func Physics_Update(delta : float):
	
	if not Player.is_on_floor():
		#is_jump = false
		Player.velocity.y -= Player.gravity * delta
	Player.Selected_Animation_Player(Player.Jump,Player.Jump,Player.animation_tree)
	
	direction = (transform.basis * Vector3(Player.input_dir.x, 0, Player.input_dir.y)).normalized()

	var get_angle_camera = camera_3d.transform.basis.get_euler().y
	var new_direction = Quaternion.from_euler(Vector3(0,get_angle_camera,0)) * direction


	Player.get_node("Body_Player").rotation.y = lerp_angle(Player.get_node("Body_Player").rotation.y, atan2(  -new_direction.x , -new_direction.z), delta *  3.5)
	direction = new_direction


		#moviment_player = 
	Player.velocity.x = direction.x * Player.SPEED 
	Player.velocity.z = direction.z * Player.SPEED

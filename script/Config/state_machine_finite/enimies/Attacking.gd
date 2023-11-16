extends State
class_name AttackingPlayer
var camera_3d 

func Enter():
	Player.get_node("Body_Player/VFX/ICe_crystal/Animation_para_Poderes").play("Magia_de_Cristal_Gelo")
	camera_3d  = get_viewport().get_camera_3d()




func Update(delta : float):
		Player.Selected_Animation_Player(Player.StateAnimation.Attacking,Player.Attack.SpellCastLong,Player.animation_tree)
		pass
	


func Physics_Update(delta : float):
##	if Player.reduzir_speed_attack:
#	var get_angle_camera = camera_3d.transform.basis.get_euler().y
#	var new_direction = Quaternion.from_euler(Vector3(0,get_angle_camera,0)) * direction
#	
#	Player.t += delta
	
	direction = get_parent().dir#new_direction
	Player.get_node("Body_Player").rotation.y = lerp_angle(Player.get_node("Body_Player").rotation.y, atan2(  -direction.x , -direction.z), delta *  3.5)
	Player.velocity.x = direction.x * 1
	Player.velocity.z = direction.z * 1
#	else:
#		if not Player.reduzir_speed_attack:
#			pass

func pode_lancar_magia():
	Bullet_function()
func _on_poderes_animation_finished(name_anime):
	if not Player.input_dir != Vector2.ZERO:
		Transitioned.emit(self, "IdlePlayer")
	elif Player.input_dir != Vector2.ZERO:
		Transitioned.emit(self,"WalkPlayer")



func Bullet_function() -> void:
	var fire_ball = preload("res://scene/scene_reutilizar/Weanpons_and_Bullet/Poder_Cristal_Gelo.tscn").instantiate()
	var marker1 = Player.get_node("Body_Player/VFX/Position_Weapons")#get_node("Body_Player/Weapons_slots_Player/M1911/Position_Fire")$Body_Player/VFX/Position_Weapons
	fire_ball.global_transform = marker1.global_transform
	get_tree().get_first_node_in_group("group_missil").add_child(fire_ball)

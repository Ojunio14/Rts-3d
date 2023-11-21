extends State
class_name TowerAttacking

var is_time : bool = false

func Enter():
	Balista.time_shoot.start()
	is_time = true
	pass


func Update(_delta : float):
		
	var vec3 = Balista.TARGET.global_position
	#var cast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
	#print(cast["position"])
	#point = cast["position"] - 
	Balista.torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y
	
	
	
	if not is_time:
		Balista.time_shoot.start()
		is_time = true


func Physics_Update(delta : float):
	Balista.target_velocity = (Balista.TARGET.global_transform.origin - Balista.target_prev_pos) / delta
	Balista.target_prev_pos = Balista.TARGET.global_transform.origin
	Balista.can_fire = true

func Exit():
	pass

func on_body_exited(body):
	if body.is_in_group("enimies"):
		Transitioned.emit(self,"TowerSearching")
	
	pass

func timeout() -> void:
	
	is_time = false
	
	#var pos_initial = spawn_projectile_marker.global_transform.origin
	#if TARGET != null:
	#var vec3 =TARGET.global_position
	var cast = Balista.raycast(Balista.spawn_projectile_marker.global_position,Balista.TARGET.global_position)
	Balista.Intercept_Dictionary["Pos_Target"] = cast["position"]
	#pos_target = Vector3(pos_target.x,pos_target.y + 0.5,pos_target.z)
	#Intercept_trajectory(spawn_projectile_marker,ProjectileArrowSpeed,pos_target,_target_velocity,spawn_projectile_marker)
	Balista.Intercept_Dictionary["_target_velocity"] = Balista._target_velocity
	Balista.Intercept_trajectory(Balista.Intercept_Dictionary)

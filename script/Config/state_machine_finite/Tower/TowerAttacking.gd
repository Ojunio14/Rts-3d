extends State
class_name TowerAttacking

var is_time : bool = false
var _target_prev_pos
var _target_velocity

enum {	IniciarTime,
		EsperaTime,
		StopTime,
		Searching
	
	}
var CurrentTime = IniciarTime

var municao

var is_attacking = true

var TimeAttacking = false

func Enter():
#	Torre.time_shoot.start()
	
	TimeAttacking = true
	pass


func Update(_delta : float):
	if  Torre.lista_alvos == []:
		Transitioned.emit(self,"TowerSearching")
		
	
	match GameManager.Current_State_Tower:
			GameManager.Estado_para_Atirar.manual:
				Transitioned.emit(self, "TowerMouseAim")
			GameManager.Estado_para_Atirar.automatico:
#				Transitioned.emit(self, "TowerAttacking")
				pass

	
#	var vec3 = Balista.TARGET.global_position
	#var cast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
	#print(cast["position"])
	#point = cast["position"] - 
#	Balista.torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y
	
	


func Physics_Update(delta : float):

	
	
	if Torre.lista_alvos != []:
		if Torre.lista_alvos[0] != null:
				
				_target_prev_pos = Torre.lista_alvos[0].global_transform.origin
				_target_velocity = (Torre.lista_alvos[0].global_transform.origin - _target_prev_pos) / delta
				
				
				if Torre.municao_da_torre_auto != 0:
					
					match CurrentTime:
						IniciarTime:
							Torre.time_shoot.start()
							CurrentTime = EsperaTime
							TimeAttacking = false
						EsperaTime:
							if TimeAttacking:
								CurrentTime = IniciarTime



func Exit():
	pass



func timeout() -> void:
	Trajetoria()

func Trajetoria() -> void:
	var RayCast
	if Torre.lista_alvos != []:
		RayCast = Torre.raycast(Torre.spawn_projectile_marker.global_position,Torre.lista_alvos[0].global_position)
		
		if RayCast != null:
			#GameManager.Current_State_Tower = GameManager.Estado_para_Atirar.automatico
			Torre.Intercept_Dictionary["Pos_Target"] = Vector3(RayCast["position"].x, RayCast["position"].y, RayCast["position"].z)
			Torre.Intercept_Dictionary["_target_velocity"] = _target_velocity
			Torre.Intercept_Dictionary["Speed"] = Torre.Projectile_Arrow_Speed_Auto
			Torre.Intercept_trajectory(Torre.Intercept_Dictionary)
			TimeAttacking = true

extends State
class_name  TowerMouseAim


var RayCast
var _target_prev_pos
var _target_velocity



func Enter():
	pass

func Update(delta : float):

	match GameManager.Current_State_Tower:
			GameManager.Estado_para_Atirar.manual:
				pass
			GameManager.Estado_para_Atirar.automatico:
				Transitioned.emit(self, "TowerAttacking")

func Physics_Update(delta : float):

	RayCast = Torre.RayCastMouse(0)
	if RayCast["collider"].is_in_group("enimies"):
		Torre.Auxilio_de_Mira.append(RayCast["collider"])
	else:
		if Torre.Auxilio_de_Mira != []:
			Torre.Auxilio_de_Mira.pop_front()
		
	if RayCast != null:
		if Torre.Auxilio_de_Mira != []:
			if Torre.Auxilio_de_Mira[0] != null:
				_target_prev_pos = Torre.Auxilio_de_Mira[0].global_position
				_target_velocity = (Torre.Auxilio_de_Mira[0].global_position - _target_prev_pos) / delta
		
		else :
			_target_prev_pos = RayCast["position"]
			_target_velocity = (RayCast["position"] - _target_prev_pos) / delta
	
	if Input.is_action_just_pressed("MouseLeft"):
		Trajetoria(GameManager.Estado_para_Atirar.manual)

func Exit():
	pass

func Trajetoria(type : int) -> void:
	var RayCast
	RayCast = Torre.RayCastMouse(0)
	if RayCast != null:
		Torre.Intercept_Dictionary["Pos_Target"] = Vector3(RayCast["position"].x, RayCast["position"].y, RayCast["position"].z)
		Torre.Intercept_Dictionary["_target_velocity"] = _target_velocity
		Torre.Intercept_Dictionary["Speed"] = Torre.Projectile_Arrow_Speed_Manual
		Torre.Intercept_trajectory(Torre.Intercept_Dictionary)

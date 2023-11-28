extends State
class_name TowerSearching


func Enter():
	pass


func Update(_delta : float):
	if Torre.lista_alvos != []:
		Transitioned.emit(self,"TowerAttacking")

	match GameManager.Current_State_Tower:
			GameManager.Estado_para_Atirar.manual:
				Transitioned.emit(self, "TowerMouseAim")
			GameManager.Estado_para_Atirar.automatico:
				pass

func Physics_Update(_delta : float):
	pass

func Exit():
	pass



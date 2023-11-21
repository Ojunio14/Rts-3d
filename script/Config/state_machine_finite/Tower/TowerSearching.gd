extends State
class_name TowerSearching


func Enter():
	
	pass


func Update(_delta : float):
	
	
	pass


func Physics_Update(_delta : float):
	pass

func Exit():
	pass


func on_body_entered(body) -> void:
	if body.is_in_group("enimies"):
		Transitioned.emit(self,"TowerAttacking")
		Balista.TARGET = body
	
	pass

extends State
class_name IdlePlayer




func Enter():
	
	pass
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and Player.is_on_floor():
		Transitioned.emit(self, "JumpPlayer")
		pass


func Update(delta : float):
	if Player.input_dir == Vector2.ZERO:
		pass
	elif Player.input_dir != Vector2.ZERO:
		Transitioned.emit(self, "WalkPlayer")
		
		pass
	


func Physics_Update(delta : float):
	Player.Selected_Animation_Player(Player.Idle,Player.Idle,Player.animation_tree)
	Player.velocity.x = move_toward(Player.velocity.x, 0, 0)
	Player.velocity.z = move_toward(Player.velocity.z, 0, 0)

	pass

func MouseLeft_Click(value):
	Transitioned.emit(self,"AttackingPlayer")

func Exit():
	pass

extends Node3D

var enimies 

var ENEMIES = preload("res://scene/Entities/scene_enimies/skeleton.tscn")

@onready var timer: Timer = $Timer



#enemies restantes para spawnar
var enemies_remaining_to_spawn


var waves
var CurrentWave : Wave
var Current_wave_number = -1

var enemies_killed_this_wave = 0

func _ready() -> void:
	waves = get_node("Waves_Main").get_children()

#	start_next_wave()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_next_wave():
	enemies_killed_this_wave = 0
	Current_wave_number += 1
	if Current_wave_number < waves.size():
		CurrentWave =  waves[Current_wave_number]
		enemies_remaining_to_spawn = CurrentWave.num_enimies
		timer.wait_time = CurrentWave.sceond_between_spawns
		timer.start()


func connect_to_enemy_signals(enemy : Enemy) -> void:
	enemy.matar_skeleton.connect(sinal_para_matar_enemy)
	
	


func sinal_para_matar_enemy() -> void:
	enemies_killed_this_wave += 1

func _on_timer_timeout() -> void:
	if enemies_remaining_to_spawn:
		var enemy = ENEMIES.instantiate()
		connect_to_enemy_signals(enemy)
		get_tree().get_first_node_in_group("group_enimies").add_child(enemy)
		enemy.global_position = self.global_position
		enemies_remaining_to_spawn -= 1
	else:
		if enemies_killed_this_wave == CurrentWave.num_enimies:
			start_next_wave()
		

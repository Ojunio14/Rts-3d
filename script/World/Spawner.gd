extends Node3D

var enimies 

var ENEMIES : PackedScene = ResourceLoader.load("res://scene/Entities/scene_enimies/skeleton.tscn") #preload("res://scene/Entities/scene_enimies/skeleton.tscn")
@onready var tempo_ondas: Control = $"../Tempo_Ondas"

@onready var timer: Timer = $Timer


@onready var counter_waves: Label = $"../Tempo_Ondas/VBoxContainer/HBox_do_level_waves/Counter_Waves"


#enemies restantes para spawnar
var enemies_remaining_to_spawn
@onready var progress_bar: ProgressBar = $"../Tempo_Ondas/VBoxContainer/ProgressBar"



var waves
var CurrentWave : Wave
var Current_wave_number = -1

var enemies_killed_this_wave = 0


var position_spawn




var group
var contador = false
var Current_orda = 0

var fim_jogo = true
func _ready() -> void:
	waves = get_node("Waves_Main").get_children()
	group = get_tree().get_first_node_in_group("group_enimies")

#	start_next_wave()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Current_orda == 7 and fim_jogo:
		get_tree().get_first_node_in_group("fim").visible = true
		fim_jogo = false
		
	
	
	pass

func start_next_wave():
	enemies_killed_this_wave = 0
	Current_wave_number += 1
	if Current_wave_number < waves.size():
		CurrentWave =  waves[Current_wave_number]
		progress_bar.max_value = CurrentWave.num_enimies
		Current_orda += 1
		counter_waves.text = str(Current_orda)
		progress_bar.value = CurrentWave.num_enimies
		
		contador = true
		enemies_remaining_to_spawn = CurrentWave.num_enimies
		timer.wait_time = CurrentWave.sceond_between_spawns
		
		timer.start()


func connect_to_enemy_signals(enemy : Enemy) -> void:
	enemy.matar_skeleton.connect(sinal_para_matar_enemy)
	
	


func sinal_para_matar_enemy() -> void:
	enemies_killed_this_wave += 1
	progress_bar.value -= 1
	GameManager.enemies_killed += 1 

func _on_timer_timeout() -> void:
	if enemies_remaining_to_spawn:
		var enemy = ENEMIES.instantiate()
		connect_to_enemy_signals(enemy)
		get_tree().get_first_node_in_group("group_enimies").add_child(enemy)
		var cord = get_parent().coord_random_array.pick_random()
		
		
		enemy.global_position = cord
		
		enemies_remaining_to_spawn -= 1
	else:
		if enemies_killed_this_wave == CurrentWave.num_enimies:
			

			start_next_wave()
			

			
				
				

		

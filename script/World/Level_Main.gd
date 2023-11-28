extends Node3D
@onready var tempo_ondas: Control = $Tempo_Ondas
var teste = preload("res://teste_.tscn")
var WAVES = preload("res://scene/scene_world/wave.tscn")


enum {
	Start_Ondas,
	Pause_Ondas,
	Stop_Ondas,
	Espera_Ondas,
	Searching_Ondas
	
}
var tamanho = 30
var CurrentOndas = Searching_Ondas
var group

var mult = 3
var Current_Waves = 0
var ondas_spawn = 1


func _ready() -> void:
	$Tempo_Ondas.connect("TIMER_ONDAS", Callable(self, "_atulizar_Estado_das_Ondas"))
	group= get_tree().get_first_node_in_group("group_enimies")


var quantidade_de_waves : int  = 15
var coord_random_array : Array = []
#


#nu
var numeros_de_enemy

var random = RandomNumberGenerator.new()
 

var esperar_Timer = true

	

func _process(delta: float) -> void:
	randomize()
	match CurrentOndas:
		Start_Ondas:
			gera_coord_para_array()
			#esperar_Timer = true
			
			GameManager.is_Ondas = true
			
			modificar_waves()
			CurrentOndas = Espera_Ondas 
			pass
		Pause_Ondas:
			pass
		Stop_Ondas:
			GameManager.is_Ondas = false

			CurrentOndas = Searching_Ondas
			
		Espera_Ondas:
			

			if group.get_child_count(true) != 0:
				pass
			else:
#				CurrentOndas = Stop_Ondas
				pass
				

		Searching_Ondas:
			
			pass
	
func getRandomPosition(size) -> Vector3:
	random.randomize()
	var x = random.randf_range(-abs(size/2), abs(size/2) )
	#var y = random.randf_range()
	var z = random.randf_range(-abs(size/2), abs(size/2))
	return Vector3(x,0.5,z)

func _atulizar_Estado_das_Ondas() -> void:
	CurrentOndas = Start_Ondas

func gera_coord_para_array():
	for l in tamanho:
		

		var coord= getRandomPosition(80)
		#print(coord)
		
		if coord.x > 20.0 or coord.x < -20.0:
			if coord.z > 20.0 or coord.z < -15.0:
				coord_random_array.append(coord)
				


	pass


func Iniciar_next_Waves():
	pass


func modificar_waves():
#	Current_Waves += 1
#	if Current_Waves > 0:
#		mult = mult + 4
#		ondas_spawn += 2 
#		for ondas_spawn
#		$Spawner/Waves_Main/Wave.num_enimies =  mult
		
			
#		$Spawner.position_spawn = coord_random_array.pick_random()
		$Spawner.start_next_wave()
		
		


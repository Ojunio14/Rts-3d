extends Node3D
@onready var tempo_ondas: Control = $Tempo_Ondas
var teste = preload("res://teste_.tscn")

enum {
	Start_Ondas,
	Pause_Ondas,
	Stop_Ondas,
	Espera_Ondas,
	Searching_Ondas
	
}
var tamanho = 1
var CurrentOndas = Searching_Ondas
var group


func _ready() -> void:
	$Tempo_Ondas.connect("TIMER_ONDAS", Callable(self, "_atulizar_Estado_das_Ondas"))
	group= get_tree().get_first_node_in_group("group_enimies")
	if -50 > -60:
		print("maior")
	else:
		print("menor")


var random = RandomNumberGenerator.new()
 
func _process(delta: float) -> void:
	randomize()
	match CurrentOndas:
		Start_Ondas:
			GameManager.is_Ondas = true
			tempo_ondas.minutes = 1
			tempo_ondas.seconds = 30
			$Spawner.start_next_wave()
			spawn()
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

func spawn():
#	for l in tamanho:
#		var tes = enimies.instantiate()
#
#		var pos = getRandomPosition(150)
#		#print(pos)
#		if pos.x > 50.0 and pos.x > -50.0:
#			if pos.z > 50.0 or pos.z > -50.0:
#
#				print("------------------------")
#				$teste_node.add_child(tes)
#				tes.global_position = pos
#
	pass





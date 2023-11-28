extends "res://script/Config/Classe/Classe_Tower.gd"
#Este Script herdando atributos da Classe Tower
#Script da Torre de Baslista

#------------------------------Onready-------------------------------------------
@onready var detected_enemy: Area3D = $Detected_Enemy

#@onready var torre: Node3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre
@onready var spawn_projectile_marker: Marker3D = $spawn_projectile_marker
@onready var time_shoot: Timer = $Time_shoot


enum {	IniciarTime,
		EsperaTime,
		StopTime,
		Searching
	
	}
var CurrentTime = IniciarTime



#------------------------------Variaveis-------------------------------------------
#========variaveis para o projectile===
#var _target_prev_pos #$Target.global_transform.origin
#var _target_velocity = Vector3.ZERO
var Intercept_Dictionary : Dictionary = {
	"Pos_Initial" : Vector3(),
	"Speed" : ProjectileArrowSpeed,
	"Pos_Target" : Vector3(),
	"_target_velocity" : Vector3(),
	"Marker" : Object
	}



var municao_da_torre_auto = 5

#======================================
#momento em
var TimeAttacking : bool = true
#var TARGET = null


var CurrentStateTower = StateTower.Searching
var is_attacking : bool = false
# pega adiciona lista de inimies que netra na area
var lista_alvos : Array = []
var  Auxilio_de_Mira : Array = []

func _ready() -> void:
	detected_enemy.body_entered.connect(on_body_entered)
	detected_enemy.body_exited.connect(on_body_exited)
	time_shoot.timeout.connect(timeout)
	
	Intercept_Dictionary["Marker"] = spawn_projectile_marker
	
	$Collision_Area_Building.connect("area_entered",Callable(self, "on_area_entered"))
	$Collision_Area_Building.connect("area_exited",Callable(self, "on_area_exited"))
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("M"):
		match GameManager.Current_State_Tower:
			GameManager.Estado_para_Atirar.manual:
				GameManager.Current_State_Tower = GameManager.Estado_para_Atirar.automatico
			GameManager.Estado_para_Atirar.automatico:
				GameManager.Current_State_Tower = GameManager.Estado_para_Atirar.manual
	

#------------------------------Funçoes  de Sginal da Area3D-------------------------------------------
#verifica se enimies entrou dentro da area da Tower
func on_body_entered(body):
	if body is Enemy  :
		lista_alvos.append(body)
func on_body_exited(body):
	if body is Enemy :
		lista_alvos.remove_at(lista_alvos.find(body))
#-------------------------------------------
#verifica se area desse object esta colidindo com outro oBject
func on_area_entered(area):
	if area.name == "Collision_Area_Building":
		if activeBuildingObject:
			BuildManager.AbleBuilding = false
			objects.append(area)

func on_area_exited(area):
	if area.name == "Collision_Area_Building":
		if activeBuildingObject:
			objects.remove_at(objects.find(area))
			if objects.size() <= 0:
				BuildManager.AbleBuilding = true

#------------------------------Onready-------------------------------------------
func timeout():
	pass

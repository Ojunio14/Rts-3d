extends "res://script/Config/Classe/Classe_Tower.gd"
#Este Script herdando atributos da Classe Tower
#Script da Torre de Baslista

#------------------------------Onready-------------------------------------------
@onready var detected_enimies: Area3D = $detected_enimies
#@onready var torre: Node3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre
@onready var spawn_projectile_marker: Marker3D = $spawn_projectile_marker
@onready var time_shoot: Timer = $Time_shoot

#------------------------------Variaveis-------------------------------------------
#========variaveis para o projectile===
var _target_prev_pos #$Target.global_transform.origin
var _target_velocity = Vector3.ZERO
var Intercept_Dictionary : Dictionary = {
	"Pos_Initial" : Vector3(),
	"Speed" : ProjectileArrowSpeed,
	"Pos_Target" : Vector3(),
	"_target_velocity" : _target_velocity,
	"Marker" : Object
	}
#======================================

var TimeAttacking : bool = false
var TARGET = null
var CurrentStateTower = StateTower.Attacking
var is_attacking : bool = false


func _ready() -> void:
	detected_enimies.body_entered.connect(on_body_entered)
	detected_enimies.body_exited.connect(on_body_exited)
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

func _physics_process(delta) -> void:
	Change_State(CurrentStateTower,delta)
	
#------------------------------Funçoes do State Machine dessa Tower-------------------------------------------
#vai decidir qual vai ser o state da Torre
func set_State_Tower(Current) -> void:
	match Current:
		StateTower.Searching:
			CurrentStateTower = StateTower.Searching
			pass
		StateTower.Attacking:
				
			CurrentStateTower = StateTower.Attacking

#vai excultar a mudança decidida do set_State_Tower
func Change_State(CurentState,delta):
	match CurentState:
		StateTower.Searching:
			pass
		StateTower.Attacking:
			_Func_State_Attacking(delta)

#------abaixor vai ter todos os EStados da Torre-----
func _Func_State_Attacking(delta) -> void:

#vai olhar para o alvo que estive dentro da area da torre
	#var vec3 = TARGET.global_position
	#torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)#transform.origin.y

#vai spawna os projectile da Torre
	match GameManager.Current_State_Tower:
		GameManager.Estado_para_Atirar.manual:
			var RayCast = RayCastMouse(0)
			if RayCast != null:
				_target_prev_pos = RayCast["position"]
				_target_velocity = (RayCast["position"] - _target_prev_pos) / delta
			#_target_prev_pos = RayCast["Position"]

			if Input.is_action_just_pressed("MouseLeft"):
				Trajetoria(GameManager.Estado_para_Atirar.manual)
				
		GameManager.Estado_para_Atirar.automatico:
			if TARGET != null:
				_target_velocity = (TARGET.global_transform.origin - _target_prev_pos) / delta
				_target_prev_pos = TARGET.global_transform.origin
			if not is_attacking:
				time_shoot.start()
				is_attacking = true

#------------------------------Funçoes  de Sginal da Area3D-------------------------------------------
#verifica se enimies entrou dentro da area da Tower
func on_body_entered(body):
	if body.is_in_group("enimies") and self.name != "BALISTA_LVL_1" :
		set_State_Tower(StateTower.Attacking)
		TARGET = body
		_target_prev_pos = body.global_transform.origin

func on_body_exited(body):
	if body.is_in_group("enimies") and self.name != "BALISTA_LVL_1":
		set_State_Tower(StateTower.Searching)

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

func Detected_State():
	pass

func timeout() -> void:
	Trajetoria(GameManager.Current_State_Tower)

func Trajetoria(type : int) -> void:
	var RayCast
	if type == 0:
		RayCast = RayCastMouse(0)
	elif type == 1:
		if TARGET != null:
			RayCast = raycast(spawn_projectile_marker.global_position,TARGET.global_position)
	if RayCast != null:
		Intercept_Dictionary["Pos_Target"] = Vector3(RayCast["position"].x, RayCast["position"].y + 0.1, RayCast["position"].z)
		Intercept_Dictionary["_target_velocity"] = _target_velocity
		Intercept_trajectory(Intercept_Dictionary)
		is_attacking = false

extends CharacterBody3D
class_name  Enemy


var life : float = 10.0

@export var movement_speed: float = 2.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

signal matar_skeleton

func _ready() -> void:
	$Area3D.connect("body_entered",Callable(self,"_on_area_3d_body_entered"))
	self.matar_skeleton.connect(vai_matar_esse_Skeleton)
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	
	
	
func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
func _process(_delta: float) -> void:
	$SubViewport/ProgressBarLife.value = life
	if life <= 0:
		#get_tree().get_first_node_in_group("WizardTower").lista_alvos.pop_front()
		emit_signal("matar_skeleton")

	if GameManager.is_Ondas:
		set_movement_target(Vector3(0,0,0))
		
		
func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var current_agent_position: Vector3 = global_position
	var new_velocity: Vector3 = (next_path_position - current_agent_position).normalized() * movement_speed
	var rot = global_position - new_velocity
	$character_skeleton_minion.look_at(rot, Vector3.UP)
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()


func _on_area_3d_body_entered(body) -> void:
#	print(life)
#	if body.is_in_group("projectile"):
#
#		life = life - body.dano
#
#		if life <= 0 :
#			queue_free()
	pass


func vai_matar_esse_Skeleton() -> void:
	call_deferred("free")

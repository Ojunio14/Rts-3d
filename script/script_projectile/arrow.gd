extends CharacterBody3D
var targetPoint
var projectile


const LIFETIME = 5.0
var dano : float = 2.5
@export var gravity = Vector3.ZERO
#export var velocity = Vector3.ZERO


	
	
var age = 0.0
func _ready() -> void:
	$Projectile_Area.connect("body_entered",Callable(self,"_on_projectile_body_entered"))
	$Timer.timeout.connect(timeout)
	$Timer.start(5)

func _physics_process(delta):
	age += delta
	velocity += gravity * delta
	#print(get_rid())
	if move_and_collide(velocity * delta) or age >= LIFETIME:
		#body.life = body.life - dano
		
		pass
#func get_shape() -> CollisionShape:
#	return $CollisionShape.shape
func _on_projectile_body_entered(body) -> void:
	if body.is_in_group("enimies"):
		body.life = body.life - dano
		queue_free()


func timeout():
	if is_inside_tree():
		queue_free()

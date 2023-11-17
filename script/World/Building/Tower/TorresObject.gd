extends "res://script/Config/Classe/Classe_Tower.gd"



@onready var detected_enimies: Area3D = $detected_enimies
#/Ballista_tower_LVL_1_001

@onready var torre: Node3D = $Balista_lvl_1/B_tower_1_rig/Skeleton3D/Torre


func _ready() -> void:
	detected_enimies.body_entered.connect(on_body_entered)
	detected_enimies.body_exited.connect(on_body_exited)

	$Collision_Area_Building.connect("area_entered",Callable(self, "on_area_entered"))
	$Collision_Area_Building.connect("area_exited",Callable(self, "on_area_exited"))


func _process(delta: float) -> void:
	if self.name != "BALISTA_LVL_1":
		if can_fire:
			var vec3 =target.global_position
			var cast = raycast($Marker3D.global_position,target.global_position)
			print(cast)
			torre.look_at(Vector3(vec3.x,transform.origin.y,vec3.z),Vector3.UP)
	if Input.is_action_just_pressed("destroy"):

		
#		spawn()
		pass
		
		
		



func on_body_entered(body):
	if body.is_in_group("enimies"):
		can_fire = true
		target = body
	pass

func on_body_exited(body):
	
	
	pass

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
	


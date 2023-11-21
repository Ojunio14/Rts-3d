extends "res://script/Config/Classe/Classe_Tower.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Collision_Area_Building.connect("area_entered",Callable(self, "on_area_entered"))
	$Collision_Area_Building.connect("area_exited",Callable(self, "on_area_exited"))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	

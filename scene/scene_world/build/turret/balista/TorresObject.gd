extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area3D.connect("area_entered",Callable(self, "on_area_entered"))
	$Area3D.connect("area_exited",Callable(self, "on_area_exited"))
	pass # Replace with function body.
var activeBuildingObject : bool
var objects : Array
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass











func on_area_entered(area):
	if activeBuildingObject:
		BuildManager.AbleBuilding = false
		objects.append(area)
	
	pass
	
func on_area_exited(area):
	if activeBuildingObject:
		objects.remove_at(objects.find(area))
		if objects.size() <= 0:
			BuildManager.AbleBuilding = true
			
		
	

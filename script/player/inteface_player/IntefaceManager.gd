extends Control




func _ready() -> void:
	$Area2D.area_entered.connect(on_area2D_entered)
	$Area2D.area_exited.connect(on_area2D_exited)

func _on_button_button_down() -> void:
	if not BuildManager.CurrentSpawnable != null:
		
		BuildManager.Spawn_Balista()

func on_area2D_entered(area):
	BuildManager.AbleBuilding = false
	pass
	
func on_area2D_exited(area):
	BuildManager.AbleBuilding = true
	pass

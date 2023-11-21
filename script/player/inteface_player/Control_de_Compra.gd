extends Control

@onready var panel_barra_de_cima: Panel = $PanelBarra_de_cima






func _ready() -> void:
	$"../Area2D".area_entered.connect(on_area2D_entered)
	$"../Area2D".area_exited.connect(on_area2D_exited)




func on_area2D_entered(_area):
	BuildManager.AbleBuilding = false
	pass
	
func on_area2D_exited(_area):
	BuildManager.AbleBuilding = true
	pass


func _on_button_turrent_button_down() -> void:
	panel_barra_de_cima.visible = true
	



func _on_button_balista_button_down() -> void:
	if not BuildManager.CurrentSpawnable != null:
			BuildManager.Spawn_Balista_tower()
	
	elif BuildManager.CurrentSpawnable.is_in_group("WizardTower") :
					BuildManager.CurrentSpawnable.queue_free() 
					BuildManager.Spawn_Balista_tower()
	elif BuildManager.CurrentSpawnable.is_in_group("BalistaTower"):
				pass
				

func _on_button_wizard_button_down() -> void:
	if not BuildManager.CurrentSpawnable != null:
		BuildManager.Spawn_Wizard_tower()

	elif BuildManager.CurrentSpawnable.is_in_group("BalistaTower"):
		BuildManager.CurrentSpawnable.queue_free()
		BuildManager.Spawn_Wizard_tower()






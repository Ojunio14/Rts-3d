extends Node

@onready var start_button: Button = $MarginContainer/VBoxContainer/Container_Buttons/VBox/Start_Button







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(_on_start_button_button_down)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")
	
	
	
	pass # Replace with function body.

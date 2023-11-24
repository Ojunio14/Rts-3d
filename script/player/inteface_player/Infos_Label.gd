extends Control

var Modo_da_torre : Array = ["auto","manual"]

func _ready() -> void:
	if GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.automatico:
		$Laba/HBoxContainer/Modo_de_Tiro.text = Modo_da_torre[0] 
	elif GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.manual:
		$Laba/HBoxContainer/Modo_de_Tiro.text = Modo_da_torre[1]


func _process(delta: float) -> void:
	
	if GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.automatico:
		$Laba/HBoxContainer/Modo_de_Tiro.text = Modo_da_torre[0] 
	elif GameManager.Current_State_Tower == GameManager.Estado_para_Atirar.manual:
		$Laba/HBoxContainer/Modo_de_Tiro.text = Modo_da_torre[1]








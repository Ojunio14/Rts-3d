extends Node


enum  State {
	Play,
	Buildling,
	Destroying
}
enum Estado_para_Atirar {
	manual,
	automatico
	
}
var Current_State_Tower = Estado_para_Atirar.automatico
var CurrentState = State.Play

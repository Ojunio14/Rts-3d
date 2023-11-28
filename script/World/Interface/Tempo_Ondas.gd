extends Control

signal TIMER_ONDAS


#@onready var timer_counter: Label = $Control/HBoxContainer/Timer_counter as Label

@onready var timer_counter: Label = $VBoxContainer/HBox_do_Timer/Timer_counter



@onready var clock_timer: Timer = $CLOCK_TIMER



#@onready var timer_counter: Label = $HBoxContainer/Timer_counter as Label


@export_range(0,5) var default_minutes  :=  0

@export_range(0,59) var default_seconds :=  10

var minutes = 0
var seconds = 0


var sair = true

func _ready() -> void:
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	
	reset_clock_timer()
func _process(delta: float) -> void:
	if minutes == 0 and seconds == 0 and sair:
		emit_signal("TIMER_ONDAS")
		sair = false
#		minutes = 0
#		seconds = 50
		pass
		#clock_timer.stop()
#		if get_tree().get_first_node_in_group("group_enimies").get_child_count() == 0:
			
			#clock_timer.start()
#			pass
		#seconds = 5
		
		


func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	if minutes == 0 and seconds == 0:
		return
	seconds -= 1
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds


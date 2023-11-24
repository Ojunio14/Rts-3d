extends Control

signal TIMER_ONDAS


@onready var timer_counter: Label = $Control/HBoxContainer/Timer_counter as Label






#@onready var timer_counter: Label = $HBoxContainer/Timer_counter as Label
@onready var clock_timer: Timer = $Control/CLOCK_TIMER

@export_range(0,5) var default_minutes  :=  1

@export_range(0,59) var default_seconds :=  0

var minutes = 0
var seconds = 0




func _ready() -> void:
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	
	reset_clock_timer()
func _process(delta: float) -> void:
	if minutes == 0 and seconds == 0:

		seconds = 5
		emit_signal("TIMER_ONDAS")
		


func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	
	seconds -= 1
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds


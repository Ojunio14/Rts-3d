extends Camera3D


@export var snap := true

@onready var _prev_ratation := global_rotation
@onready var _snap_space := global_transform


func _process(delta: float) -> void:
	if global_rotation != _prev_ratation:
		_prev_ratation = global_rotation
		_snap_space = global_transform
	var texel_size := size / 180.0
	
	var snap_space_position : = global_position * _snap_space
	
	var snapped_snap_space_position := snap_space_position.snapped(Vector3.ONE * texel_size)
	var snap_error := snapped_snap_space_position - snap_space_position
	if snap:
		h_offset = snap_error.x
		v_offset = snap_error.y

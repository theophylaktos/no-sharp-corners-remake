extends Node

var object_tile_coordinates: Array[Array] = [
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
]

var segments: Array[Array] = [
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print(object_tile_coordinates)

extends Node

var ring_zero: Node
var ring_one: Node
var ring_two: Node

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

func rotate_ring(ring: int, direction: int):
	match ring:
		0:
			_rotate_ring(ring_zero, direction)
		1:
			_rotate_ring(ring_one, direction)
		2:
			_rotate_ring(ring_two, direction)
			
func _rotate_ring(ring: Node, direction: int):
	print(direction)
	for segment in ring.get_children():
		segment.tile_coordinates = Vector2i(segment.tile_coordinates.x, segment.tile_coordinates.y + direction)
		
func random_empty_segment() -> Vector2i:
	var segment_coordinates = Vector2i(randi_range(0, Constants.RING_COUNT - 1), randi_range(0, Constants.DEGREE_COUNT - 1))
	if object_tile_coordinates[segment_coordinates.x][segment_coordinates.y] == null:
		return segment_coordinates
	return random_empty_segment()

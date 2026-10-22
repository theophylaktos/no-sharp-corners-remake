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
	for segment in ring.get_children():
		segment.tile_coordinates = Vector2i(segment.tile_coordinates.x, segment.tile_coordinates.y + direction)
		
func random_empty_segment() -> Vector2i:
	var empty_segments: Array[Vector2i]
	for ring in object_tile_coordinates.size():
		for degree in object_tile_coordinates[0].size():
			if object_tile_coordinates[ring][degree] == null:
				empty_segments.append(Vector2i(ring,degree))
	return empty_segments[randi_range(0, empty_segments.size() - 1)]

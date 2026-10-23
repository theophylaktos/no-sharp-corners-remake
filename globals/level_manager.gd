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
		print()
		print(object_tile_coordinates)
		print()

func rotate_ring(ring: int, direction: int):
	match ring:
		0:
			_rotate_segments(ring_zero, direction)
			_rotate_objects(ring, direction)
		1:
			_rotate_segments(ring_one, direction)
			_rotate_objects(ring, direction)
		2:
			_rotate_segments(ring_two, direction)
			_rotate_objects(ring, direction)
			
func _rotate_segments(ring: Node, direction: int):
	for segment in ring.get_children():
		segment.tile_coordinates = Vector2i(segment.tile_coordinates.x, segment.tile_coordinates.y + direction)
		
func _rotate_objects(ring: int, direction: int):
	
	var size: int = object_tile_coordinates[ring].size()
	
	if direction > 0:
		var temp: Node = object_tile_coordinates[ring][size - 1]
		for i in range(size - 1, 0, -1):
			object_tile_coordinates[ring][i] = object_tile_coordinates[ring][i - 1]
		object_tile_coordinates[ring][0] = temp
	elif direction < 0:
		var temp: Node = object_tile_coordinates[ring][0]
		for i in range(0, object_tile_coordinates[0].size() - 1):
			object_tile_coordinates[ring][i] = object_tile_coordinates[ring][i + 1]
		object_tile_coordinates[ring][-1] = temp
		
	for i in range(size):
		if object_tile_coordinates[ring][i] != null:
			object_tile_coordinates[ring][i].tile_coordinates = Vector2i(ring, i - 1)
			object_tile_coordinates[ring][i].tile_coordinates = Vector2i(ring, i)
			
func random_empty_segment() -> Vector2i:
	var empty_segments: Array[Vector2i]
	for ring in object_tile_coordinates.size():
		for degree in object_tile_coordinates[0].size():
			if object_tile_coordinates[ring][degree] == null:
				empty_segments.append(Vector2i(ring,degree))
	return empty_segments[randi_range(0, empty_segments.size() - 1)]

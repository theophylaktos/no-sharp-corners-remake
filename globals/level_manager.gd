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
	if direction > 0:
		var temp: Node2D = object_tile_coordinates[ring][Constants.DEGREE_SIZE]
		print(temp)
		for i in range(Constants.DEGREE_SIZE - 1, -1, -1):
			if object_tile_coordinates[ring][i] != null:
				object_tile_coordinates[ring][i].tile_coordinates = Vector2i(ring, i + 1)
		if temp != null:
			temp.tile_coordinates = Vector2i(ring, 0)
	if direction < 0:
		var temp: Node2D = object_tile_coordinates[ring][0]
		for i in range(1, Constants.DEGREE_SIZE + 1):
			if object_tile_coordinates[ring][i] != null:
				object_tile_coordinates[ring][i].tile_coordinates = Vector2i(ring, i - 1)
		if temp != null:
			temp.tile_coordinates = Vector2i(ring, Constants.DEGREE_SIZE)
func random_empty_segment() -> Vector2i:
	var empty_segments: Array[Vector2i]
	for ring in object_tile_coordinates.size():
		for degree in object_tile_coordinates[0].size():
			if object_tile_coordinates[ring][degree] == null:
				empty_segments.append(Vector2i(ring,degree))
	return empty_segments[randi_range(0, empty_segments.size() - 1)]

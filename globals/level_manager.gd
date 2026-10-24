extends Node

var ring_zero: Node2D
var ring_one: Node2D
var ring_two: Node2D

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
			
func _rotate_segments(ring: Node2D, direction: int):
		ring.ring_rotation += direction
	
func _rotate_objects(ring: int, direction: int):
	if direction > 0:
		var temp: Node2D = object_tile_coordinates[ring][Constants.DEGREE_SIZE]
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

func enable_enemy_attack_segment(ring: int, degree: int):
	var material: ShaderMaterial = segments[ring][degree].get_material()
	material.set_shader_parameter("player_attack_enabled", true)

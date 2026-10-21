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
	pass
	#for segment in ring.get_children():
		#var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
		#tween.tween_method(
			#func(value: float) -> void:
				#self.rotation = lerp_angle(self.rotation, (PI / 8) + clamped_y * (PI / 4), value), 0.0, 1.0, Constants.ROTATE_TIME
		#)
	#
		#tween.parallel().tween_method(
		#func(value: float) -> void:
			#self.local.rotation = lerp_angle(local.rotation, -1 * ((PI / 8) + clamped_y * (PI / 4)), value), 0.0, 1.0, Constants.ROTATE_TIME
		#)
		#
		#tween.parallel().tween_property(self.local, "position", Vector2(Constants.DISTANCES[clamped_x], 0), Constants.ROTATE_TIME)

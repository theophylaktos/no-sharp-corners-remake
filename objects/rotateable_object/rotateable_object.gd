extends Node2D
class_name RotateableObject

@export var local: Node2D

## X is the ring, Y is the degree
@export var tile_coordinates = Vector2i(0,0):
	set(new_value):
		LevelManager.object_tile_coordinates[tile_coordinates.x][tile_coordinates.y] = null
		var clamped_x: int = clampi(new_value.x, 0, Constants.RING_COUNT)
		var clamped_y: int = posmod(new_value.y, Constants.DEGREE_COUNT)
		tile_coordinates = Vector2(clamped_x, clamped_y)
		LevelManager.object_tile_coordinates[clamped_x][clamped_y] = self
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_method(
			func(value: float) -> void:
				self.rotation = lerp_angle(self.rotation, (PI / 8) + clamped_y * (PI / 4), value), 0.0, 1.0, Constants.ROTATE_TIME
		)
	
		tween.parallel().tween_method(
		func(value: float) -> void:
			self.local.rotation = lerp_angle(local.rotation, -1 * ((PI / 8) + clamped_y * (PI / 4)), value), 0.0, 1.0, Constants.ROTATE_TIME
		)
		
		tween.parallel().tween_property(self.local, "position", Vector2(Constants.DISTANCES[clamped_x], 0), Constants.ROTATE_TIME)

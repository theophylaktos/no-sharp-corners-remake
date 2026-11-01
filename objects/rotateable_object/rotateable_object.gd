extends Node2D
class_name RotateableObject

@export var local: Node2D

## X is the ring, Y is the degree
@export var tile_coordinates: Vector2i = Vector2i(-1, -1):
	set(new_value):
		if tile_coordinates.x >= 0 && tile_coordinates.y >= 0 && LevelManager.object_tile_coordinates[tile_coordinates.x][tile_coordinates.y] == self:
			LevelManager.object_tile_coordinates[tile_coordinates.x][tile_coordinates.y] = null
		var clamped_x: int = clampi(new_value.x, 0, Constants.RING_SIZE)
		var clamped_y: int = posmod(new_value.y, Constants.DEGREE_SIZE + 1)
		
		var start_rotation = (PI / 8) + tile_coordinates.y * (PI / 4)
		var end_rotation = (PI / 8) + clamped_y * (PI / 4)
		
		tile_coordinates = Vector2i(clamped_x, clamped_y)
		LevelManager.object_tile_coordinates[clamped_x][clamped_y] = self
		
		if self.has_method("play_idle"):
			self.call("play_idle")
		
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_method(
			func(value: float) -> void:
				rotate_sprite(start_rotation, end_rotation, value), 0.0, 1.0, Constants.ROTATE_TIME
		)

func rotate_sprite(start_rotation, end_rotation, value):
	var current_rotation = lerp_angle(start_rotation, end_rotation, value)
	position = Vector2(cos(current_rotation), sin(current_rotation)) * Constants.DISTANCES[tile_coordinates.x]
	position = position.round()

extends Sprite2D

@export var tile_coordinates = Vector2i(-1,-1):
	set(new_value):
		if tile_coordinates.x >= 0 && tile_coordinates.y >= 0 && LevelManager.segments[tile_coordinates.x][tile_coordinates.y] == self:
			LevelManager.segments[tile_coordinates.x][tile_coordinates.y] = null
		var clamped_y: int = posmod(new_value.y, Constants.DEGREE_SIZE + 1)
		tile_coordinates = Vector2i(new_value.x, clamped_y)
		LevelManager.segments[new_value.x][clamped_y] = self
		
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
		var start_rotation = self.rotation
		var end_rotation = clamped_y * (PI / 4)
		self.texture_filter = TEXTURE_FILTER_LINEAR
		tween.tween_method(
			func(value: float) -> void:
				self.rotation = lerp_angle(start_rotation, end_rotation, value), 0.0, 1.0, Constants.ROTATE_TIME
		)
		await tween.finished
		self.texture_filter = TEXTURE_FILTER_NEAREST

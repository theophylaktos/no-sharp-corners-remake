extends Sprite2D

@export var tile_coordinates = Vector2i(0,0):
	set(new_value):
		tile_coordinates = new_value
		var clamped_y: int = posmod(new_value.y, Constants.DEGREE_COUNT)
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

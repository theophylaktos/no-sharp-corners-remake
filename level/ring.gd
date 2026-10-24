extends Node2D

var ring_rotation = 0:
	set(new_value):
		var clamped: int = posmod(new_value, Constants.DEGREE_SIZE + 1)
		ring_rotation = clamped
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
		var start_rotation = self.rotation
		var end_rotation = clamped * (PI / 4)
		self.texture_filter = TEXTURE_FILTER_LINEAR
		tween.tween_method(
			func(value: float) -> void:
				self.rotation = lerp_angle(start_rotation, end_rotation, value), 0.0, 1.0, Constants.ROTATE_TIME
		)
		await tween.finished
		self.texture_filter = TEXTURE_FILTER_NEAREST

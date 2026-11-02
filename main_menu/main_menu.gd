extends Control

func _on_button_pressed() -> void:
	SFX.play(SFX.Id.BUTTON_PRESS)


func _on_button_mouse_entered() -> void:
		SFX.play(SFX.Id.BUTTON_HOVER)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")

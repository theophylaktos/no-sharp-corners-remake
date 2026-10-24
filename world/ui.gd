extends Node

func _on_first_attack_pressed() -> void:
	play_sound_on_item_clicked(RoundManager.attacks[0])
	PlayerInputs.first_attack_pressed.emit()
	%FirstAttack.material.set_shader_parameter("is_outlined", true)
	%SecondAttack.material.set_shader_parameter("is_outlined", false)
	%ThirdAttack.material.set_shader_parameter("is_outlined", false)

func _on_second_attack_pressed() -> void:
	play_sound_on_item_clicked(RoundManager.attacks[1])
	PlayerInputs.second_attack_pressed.emit()
	%FirstAttack.material.set_shader_parameter("is_outlined", false)
	%SecondAttack.material.set_shader_parameter("is_outlined", true)
	%ThirdAttack.material.set_shader_parameter("is_outlined", false)

func _on_third_attack_pressed() -> void:
	play_sound_on_item_clicked(RoundManager.attacks[2])
	PlayerInputs.third_attack_pressed.emit()
	%FirstAttack.material.set_shader_parameter("is_outlined", false)
	%SecondAttack.material.set_shader_parameter("is_outlined", false)
	%ThirdAttack.material.set_shader_parameter("is_outlined", true)
	
func play_sound_on_item_clicked(item: String) -> void:
	if ["diagonal", "attack2", "all_diagonals", "all_horizontals", "attack"].has(item):
		SFX.play(SFX.Id.GLASS_TAP)
		SFX.play(SFX.Id.METAL_TAP)
	if ["attack4", "knight"].has(item):
		SFX.play(SFX.Id.WOOD)
	else:
		SFX.play(SFX.Id.WOOD)

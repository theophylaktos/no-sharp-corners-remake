extends Node

func _ready() -> void:
	RoundManager.equipped_weapon_changed.connect(func(): update_highlights(RoundManager.attacks.find(RoundManager.selected_attack)))

func _on_first_attack_pressed() -> void:
	PlayerInputs.first_attack_pressed.emit()
	update_highlights(0)

func _on_second_attack_pressed() -> void:
	PlayerInputs.second_attack_pressed.emit()
	update_highlights(1)

func _on_third_attack_pressed() -> void:
	PlayerInputs.third_attack_pressed.emit()
	update_highlights(2)
	
func update_highlights(slot: int) -> void:
	print(slot)
	match slot:
		0:
			%FirstAttack.material.set_shader_parameter("is_outlined", true)
			%SecondAttack.material.set_shader_parameter("is_outlined", false)
			%ThirdAttack.material.set_shader_parameter("is_outlined", false)
			play_sound_on_item_clicked(RoundManager.attacks[0])
			return
		1:
			%FirstAttack.material.set_shader_parameter("is_outlined", false)
			%SecondAttack.material.set_shader_parameter("is_outlined", true)
			%ThirdAttack.material.set_shader_parameter("is_outlined", false)
			play_sound_on_item_clicked(RoundManager.attacks[1])
			return
		2:
			%FirstAttack.material.set_shader_parameter("is_outlined", false)
			%SecondAttack.material.set_shader_parameter("is_outlined", false)
			%ThirdAttack.material.set_shader_parameter("is_outlined", true)
			play_sound_on_item_clicked(RoundManager.attacks[2])
			return
			
func play_sound_on_item_clicked(item: String) -> void:
	if ["diagonal", "attack2", "all_diagonals", "all_horizontals", "attack"].has(item):
		SFX.play(SFX.Id.GLASS_TAP)
		SFX.play(SFX.Id.METAL_TAP)
	if ["attack4", "knight"].has(item):
		SFX.play(SFX.Id.WOOD)
	else:
		SFX.play(SFX.Id.WOOD)


func _on_pause_button_pressed() -> void:
	PlayerInputs.accepting_input = false
	%Settings.visible = true

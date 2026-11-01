extends Node

func _ready() -> void:
	RoundManager.selected_weapon_changed.connect(func(): update_highlights(RoundManager.selected_attack))
	_attacks_changed()
	RoundManager.health_changed.connect(func(): play_health_loss_animation(RoundManager.health_left))
	RoundManager.moves_changed.connect(func(): play_move_loss_animation(RoundManager.moves_left))
	RoundManager.attacks_changed.connect(func(): play_attack_loss_animation(RoundManager.attacks_left))
	
	GameState.health_max_changed.connect(func(): update_max_health(GameState.health_max))
	GameState.moves_max_changed.connect(func(): update_max_moves(GameState.moves_max))
	GameState.attacks_max_changed.connect(func(): update_max_attacks(GameState.attacks_max))
	update_max_health(GameState.health_max)
	update_max_moves(GameState.moves_max)
	update_max_attacks(GameState.attacks_max)
	
	$SubmitAttack.disabled = true
	RoundManager.change_to_player_attack.connect(func(): $SubmitAttack.disabled = false)
	RoundManager.change_to_enemy_move.connect(func(): $SubmitAttack.disabled = true)
	
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
	match slot:
		-1:
			%FirstAttack.material.set_shader_parameter("is_outlined", false)
			%SecondAttack.material.set_shader_parameter("is_outlined", false)
			%ThirdAttack.material.set_shader_parameter("is_outlined", false)
			return
		0:
			%FirstAttack.material.set_shader_parameter("is_outlined", true)
			%SecondAttack.material.set_shader_parameter("is_outlined", false)
			%ThirdAttack.material.set_shader_parameter("is_outlined", false)
			play_sound_on_item_clicked(GameState.attacks[0])
			return
		1:
			%FirstAttack.material.set_shader_parameter("is_outlined", false)
			%SecondAttack.material.set_shader_parameter("is_outlined", true)
			%ThirdAttack.material.set_shader_parameter("is_outlined", false)
			play_sound_on_item_clicked(GameState.attacks[1])
			return
		2:
			%FirstAttack.material.set_shader_parameter("is_outlined", false)
			%SecondAttack.material.set_shader_parameter("is_outlined", false)
			%ThirdAttack.material.set_shader_parameter("is_outlined", true)
			play_sound_on_item_clicked(GameState.attacks[2])
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
	SFX.play(SFX.Id.WOOD)
	PlayerInputs.accepting_input = false
	%Settings.visible = true

func _attacks_changed() -> void:
	if Constants.WEAPON_SPRITES.get(GameState.attacks[0]) != null:
		%FirstAttack.texture_normal = Constants.WEAPON_SPRITES[GameState.attacks[0]]
	if Constants.WEAPON_SPRITES.get(GameState.attacks[1]) != null:
		%SecondAttack.texture_normal = Constants.WEAPON_SPRITES[GameState.attacks[1]]
	if Constants.WEAPON_SPRITES.get(GameState.attacks[2]) != null:
		%ThirdAttack.texture_normal = Constants.WEAPON_SPRITES[GameState.attacks[2]]
	
func _on_submit_attack_pressed() -> void:
	RoundManager.attacks_left -= 1
	PlayerInputs.submit_attack_pressed.emit()
	
func update_max_health(amount: int) -> void:
	for heart in amount:
		var icon: AnimatedSprite2D = Constants.HEART_ICON.instantiate()
		icon.name = "heart" + str(heart)
		icon.position = Vector2(165, -57)
		icon.position.x -= heart * 18
		$HeartIcons.add_child(icon)

func update_max_moves(amount: int) -> void:
	for move in amount:
		var icon: AnimatedSprite2D = Constants.MOVE_ICON.instantiate()
		icon.name = "move" + str(move)
		icon.position = Vector2(165 - (GameState.attacks_max * 18), -39)
		icon.position.x -= move * 18
		$MoveIcons.add_child(icon)
				
func update_max_attacks(amount: int) -> void:
	for attack in amount:
		var icon: AnimatedSprite2D = Constants.ATTACK_ICON.instantiate()
		icon.name = "attack" + str(attack)
		icon.position = Vector2(165, -39)
		icon.position.x -= attack * 18
		$AttackIcons.add_child(icon)
		
func play_health_loss_animation(heart: int) -> void:
	var sprite: AnimatedSprite2D = $HeartIcons.get_child(heart - 1)
	sprite.play("drain")
	
func play_move_loss_animation(move: int) -> void:
	match move:
		3:
			return
		2, 1, 0:
			var sprite: AnimatedSprite2D = $MoveIcons.get_child(move)
			sprite.play("used")
		0:
			_on_first_attack_pressed()
func play_attack_loss_animation(attack: int) -> void:
	match attack:
		0:
			var sprite: AnimatedSprite2D = $AttackIcons.get_child(attack)
			sprite.play("used")
			update_highlights(-1)
			switch_attacks_disabled(true)
	
func switch_attacks_disabled(switch: bool):
	%FirstAttack.disabled = switch
	%SecondAttack.disabled = switch
	%ThirdAttack.disabled = switch

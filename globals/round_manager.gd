extends Node

@export var world: Node2D

signal change_to_player_move
signal change_to_player_attack
signal change_to_enemy_move
signal change_to_enemy_attack

@export var phase: String = "player_move":
	set(new_value):
		phase = new_value
		match new_value:
			"player_move":
				change_to_player_move.emit()
			"player_attack":
				change_to_player_attack.emit()
			"enemy_attack":
				change_to_enemy_attack.emit()
				enemy_attacks()
			"enemy_move":
				change_to_enemy_move.emit()
	
var selected_attack: int = 0

signal moves_changed
@onready var moves_left: int = GameState.moves_max:
	set(new_value):
		moves_left = new_value
		moves_changed.emit()
		if moves_left == 0:
			phase = "player_attack"

signal attacks_changed
@onready var attacks_left: int = GameState.attacks_max:
	set(new_value):
		attacks_left = new_value
		attacks_changed.emit()
		if moves_left == 0:
			phase = "enemy_attack"

signal debug_pressed

signal player_move_left
signal player_move_right
signal player_move_up
signal player_move_down

signal player_select_left
signal player_select_right
signal player_select_up
signal player_select_down

signal selected_weapon_changed

const ENEMY_SCENE = preload("uid://do4qeckfx47bx")

func _ready() -> void:
	PlayerInputs.left_pressed.connect(_player_move_left)
	PlayerInputs.right_pressed.connect(_player_move_right)
	PlayerInputs.up_pressed.connect(_player_move_up)
	PlayerInputs.down_pressed.connect(_player_move_down)
	
	PlayerInputs.first_attack_pressed.connect(func(): _select_weapon(0))
	PlayerInputs.second_attack_pressed.connect(func(): _select_weapon(1))
	PlayerInputs.third_attack_pressed.connect(func(): _select_weapon(2))
	
	PlayerInputs.select_left_pressed.connect(func(): _select_weapon(selected_attack - 1))
	PlayerInputs.select_right_pressed.connect(func(): _select_weapon(selected_attack + 1))
	
	PlayerInputs.debug_pressed.connect(_debug_pressed)
	
	PlayerInputs.submit_attack_pressed.connect(damage_enemies)
	start_round()
	
func _process(delta: float) -> void:
	LevelManager.refresh_enemy_highlights()
	
func _debug_pressed():
	debug_pressed.emit()
	
func _player_move_left():
	if phase == "player_move":
		player_move_left.emit()
	if phase == "player_attack":
		player_select_left.emit()
		
func _player_move_right():
	if phase == "player_move":
		player_move_right.emit()
	if phase == "player_attack":
		player_select_right.emit()
		
func _player_move_up():
	if phase == "player_move":
		player_move_up.emit()
	if phase == "player_attack":
		player_select_up.emit()
		
func _player_move_down():
	if phase == "player_move":
		player_move_down.emit()
	if phase == "player_attack":
		player_select_down.emit()

func decrease_attacks():
	attacks_left -= 1
	if attacks_left == 0:
		phase = "player_move"

func start_round():
	await add_player()
	add_enemies()
	
func add_player():
	var player = load("uid://b8tibli3auw72").instantiate()
	while (world == null):
		await get_tree().create_timer(0.01).timeout
	world.add_child(player)
	player.tile_coordinates = Vector2(0,0)
	
func add_enemies():
	for enemy in Rounds.rounds[GameState.current_round]:
		add_enemy(enemy)
	
func add_enemy(enemy_type: String):
	var enemy: Node2D
	enemy = ENEMY_SCENE.instantiate()
	enemy.enemy_type = enemy_type
	enemy.name = enemy_type + str(Time.get_ticks_usec())
	while (world == null):
		await get_tree().create_timer(0.01).timeout
	if (enemy == null):
		return
	world.add_child(enemy)
	enemy.tile_coordinates = LevelManager.random_empty_segment()
	
func _select_weapon(slot: int):
	if phase == "player_attack":
		selected_attack = clampi(slot, 0, 2)
		selected_weapon_changed.emit()
	
func damage_enemies():
	for ring in LevelManager.segments.size():
		for degree in LevelManager.segments[0].size():
			var material: ShaderMaterial = LevelManager.segments[ring][degree].get_material()
			if material.get_shader_parameter("player_attack_enabled") == true:
				var node = LevelManager.object_tile_coordinates[ring][degree]
				if node is Enemy:
					if Constants.ENEMY_HEALTH[node.enemy_type] - node.health <= 0:
						node.play_enemy_sound("Death")
					node.health -= GameState.player_damage
					await get_tree().create_timer(1).timeout
	if attacks_left <= 0:
		LevelManager.clear_all_player_attack_segments()

func enemy_attacks():
	for ring in LevelManager.segments.size():
		for degree in LevelManager.segments[0].size():
			var node = LevelManager.object_tile_coordinates[ring][degree]
			if node is Enemy:
				print("hi")
				enemy_attack(node)

func enemy_attack(node: Enemy):
	for attack in AttackPatterns.enemy_attack_patterns[node.enemy_type]:
		var attack_position: Vector2i = attack + node.tile_coordinates
		attack_position.y = posmod(attack_position.y, Constants.DEGREE_SIZE + 1)
		
		if attack_position.x < 0 or attack_position.x > 2:
			continue
		if LevelManager.object_tile_coordinates[attack_position.x][attack_position.y] != Player:
			continue
			
	node.play_attack()
	await node.animation_finshed
	node.play_idle()

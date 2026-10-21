extends Node

var current_round: int = 0

@export var world: Node2D

@export var phase: String = "player_move"

signal player_move_left
signal player_move_right
signal player_move_up
signal player_move_down

func _ready() -> void:
	PlayerInputs.left_pressed.connect(_player_move_left)
	PlayerInputs.right_pressed.connect(_player_move_right)
	PlayerInputs.up_pressed.connect(_player_move_up)
	PlayerInputs.down_pressed.connect(_player_move_down)
	start_round()
	
func _player_move_left():
	if phase == "player_move":
		player_move_left.emit()
		
func _player_move_right():
	if phase == "player_move":
		player_move_right.emit()
		
func _player_move_up():
	if phase == "player_move":
		player_move_up.emit()
		
func _player_move_down():
	if phase == "player_move":
		player_move_down.emit()

func start_round():
	add_player()
	add_enemies()

func add_player():
	var player = load("uid://b8tibli3auw72").instantiate()
	while (world == null):
		await get_tree().create_timer(0.01).timeout
	world.add_child(player)
	player.tile_coordinates = Vector2(0,0)
	
func add_enemies():
	for enemy in Rounds.rounds[current_round]:
		add_enemy(enemy)
		
func add_enemy(enemy_name: String):
	var enemy: Node2D
	match enemy_name:
		"mushroom":
			enemy = load("uid://do4qeckfx47bx").instantiate()
			
	while (world == null):
		await get_tree().create_timer(0.01).timeout
	if (enemy == null):
		return
	world.add_child(enemy)
	enemy.tile_coordinates = Vector2(0,0)

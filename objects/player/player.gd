extends DamageableObject

var direction: String = ""

func _ready() -> void:
	local = $Local
	RoundManager.player_move_left_pressed.connect(move_left)
	RoundManager.player_move_right_pressed.connect(move_right)
	RoundManager.player_move_up_pressed.connect(move_up)
	RoundManager.player_move_down_pressed.connect(move_down)

func calculate_direction() -> String:
	if tile_coordinates.y == 0 or tile_coordinates.y == 7:
		return "Right"
	if tile_coordinates.y == 1 or tile_coordinates.y == 2:
		return "Down"
	if tile_coordinates.y == 3 or tile_coordinates.y == 4:
		return "Left"
	if tile_coordinates.y == 5 or tile_coordinates.y == 6:
		return "Up"
	return "ERROR: Invalid Degree"

func move_left():
	direction = calculate_direction()
	if direction == "Right":
		_move_in()
	if direction == "Down":
		_rotate_ring(1)
	if direction == "Left":
		_move_out()
	if direction == "Up":
		_rotate_ring(-1)
	
func move_right():
	direction = calculate_direction()
	if direction == "Right":
		_move_out()
	if direction == "Down":
		_rotate_ring(-1)
	if direction == "Left":
		_move_in()
	if direction == "Up":
		_rotate_ring(1)
		
func move_up():
	direction = calculate_direction()
	if direction == "Right":
		_rotate_ring(-1)
	if direction == "Down":
		_move_in()
	if direction == "Left":
		_rotate_ring(1)
	if direction == "Up":
		_move_out()
	
func move_down():
	direction = calculate_direction()
	if direction == "Right":
		_rotate_ring(1)
	if direction == "Down":
		_move_out()
	if direction == "Left":
		_rotate_ring(-1)
	if direction == "Up":
		_move_in()
		
func _move_in():
	if tile_coordinates.x + 1 <= 2:
		if LevelManager.object_tile_coordinates[tile_coordinates.x + 1][tile_coordinates.y] != null:
			return
		tile_coordinates = Vector2i(tile_coordinates.x + 1, tile_coordinates.y)
	
func _move_out():
	if tile_coordinates.x - 1 >= 0:
		if LevelManager.object_tile_coordinates[tile_coordinates.x - 1][tile_coordinates.y] != null:
			return
		tile_coordinates = Vector2i(tile_coordinates.x - 1, tile_coordinates.y)
	
func _rotate_ring(amount: int):
	tile_coordinates = Vector2i(tile_coordinates.x, tile_coordinates.y + amount)

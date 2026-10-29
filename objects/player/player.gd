extends DamageableObject

class_name Player

var direction: String = ""

var selected_direction: String = "W"

func _ready() -> void:
	local = $Local
	RoundManager.player_move_left.connect(move_left)
	RoundManager.player_move_right.connect(move_right)
	RoundManager.player_move_up.connect(move_up)
	RoundManager.player_move_down.connect(move_down)
	
	RoundManager.player_select_left.connect(select_left)
	RoundManager.player_select_right.connect(select_right)
	RoundManager.player_select_up.connect(select_up)
	RoundManager.player_select_down.connect(select_down)
	
	RoundManager.selected_weapon_changed.connect(toggle)
	
	RoundManager.debug_pressed.connect(debug)

func debug() -> void:
	toggle()

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
		RoundManager.decrease_moves()
		SFX.play(SFX.Id.SLIME)
		tile_coordinates = Vector2i(tile_coordinates.x + 1, tile_coordinates.y)
	
func _move_out():
	if tile_coordinates.x - 1 >= 0:
		if LevelManager.object_tile_coordinates[tile_coordinates.x - 1][tile_coordinates.y] != null:
			return
		RoundManager.decrease_moves()
		SFX.play(SFX.Id.SLIME)
		tile_coordinates = Vector2i(tile_coordinates.x - 1, tile_coordinates.y)
	
func _rotate_ring(amount: int):
	SFX.play(SFX.Id.ROCK)
	LevelManager.rotate_ring(tile_coordinates.x, amount)
	RoundManager.decrease_moves() 
	
func select_left():
	selected_direction = "A"
	toggle()
	
func select_right():
	selected_direction = "D"
	toggle()
	
func select_up():
	selected_direction = "W"
	toggle()
	
func select_down():
	selected_direction = "S"
	toggle()
func toggle():
	LevelManager.clear_all_player_attack_segments()
	for i in AttackPatterns.player_attack_patterns[RoundManager.attacks[RoundManager.selected_attack]].size():
		var x = AttackPatterns.player_attack_patterns[RoundManager.attacks[RoundManager.selected_attack]][i].x
		var y = AttackPatterns.player_attack_patterns[RoundManager.attacks[RoundManager.selected_attack]][i].y
		
		var faces: Dictionary[String, Vector2] = {
			"Forward": Vector2i(tile_coordinates.x, tile_coordinates.y) + Vector2i(x, y),
			"Backward": Vector2i(tile_coordinates.x, tile_coordinates.y) + Vector2i(-x, -y),
			"Leftward": Vector2i(tile_coordinates.x, tile_coordinates.y) + Vector2i(y, x),
			"Rightward": Vector2i(tile_coordinates.x, tile_coordinates.y) + Vector2i(-y, -x),
		}
		
		direction = calculate_direction()
		
		var segment: Vector2i = Vector2i(0,0)		
		
		if selected_direction == "W":
			if direction == "Right":
				segment = faces["Rightward"]
			if direction == "Down":
				segment = faces["Forward"]
			if direction == "Left":
				segment = faces["Leftward"]
			if direction == "Up":
				segment = faces["Backward"]
		
		if selected_direction == "S":
			if direction == "Right":
				segment = faces["Leftward"]
			if direction == "Down":
				segment = faces["Backward"]
			if direction == "Left":
				segment = faces["Rightward"]
			if direction == "Up":
				segment = faces["Forward"]
				
		if selected_direction == "A":
			if direction == "Right":
				segment = faces["Forward"]
			if direction == "Down":
				segment = faces["Leftward"]
			if direction == "Left":
				segment = faces["Backward"]
			if direction == "Up":
				segment = faces["Rightward"]
				
		if selected_direction == "D":
			if direction == "Right":
				segment = faces["Backward"]
			if direction == "Down":
				segment = faces["Rightward"]
			if direction == "Left":
				segment = faces["Forward"]
			if direction == "Up":
				segment = faces["Leftward"]
				
		if segment.x >= 0 and segment.x <= 2:
			if segment.y < 0:
				segment.y = 8 + segment.y
			segment.y = segment.y % 8
			LevelManager.enable_player_attack_segment(segment.x, segment.y)

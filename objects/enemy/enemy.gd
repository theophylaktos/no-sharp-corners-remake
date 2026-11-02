extends DamageableObject

class_name Enemy

var is_dying = false

signal animation_finshed

@export var enemy_type: String = "":
	set(new_value):
		enemy_type = new_value
		update_type(enemy_type)
		
func update_type(type: String):
	%Sprite.sprite_frames = Constants.ENEMY_SPRITE_FRAMES[type]
	
func _ready() -> void:
	health = Constants.ENEMY_HEALTH[enemy_type]
	play_idle()
	update_healthbar()
	
func update_healthbar():
	%HealthBar.value = (self.health * 1.0) / (Constants.ENEMY_HEALTH[enemy_type] * 1.0)
	
func play_idle():
	if not is_dying:
		if tile_coordinates.y == 7 or tile_coordinates.y == 0:
			if %Sprite.animation != "idle_right":
				%Sprite.play("idle_right")
		if tile_coordinates.y == 1 or tile_coordinates.y == 2:
			if %Sprite.animation != "idle_back":
				%Sprite.play("idle_back")
		if tile_coordinates.y == 3 or tile_coordinates.y == 4:
			if %Sprite.animation != "idle_left":
				%Sprite.play("idle_left")
		if tile_coordinates.y == 5 or tile_coordinates.y == 6:
			if %Sprite.animation != "idle_front":
				%Sprite.play("idle_front")
				
func play_attack():
	play_enemy_sound("attack")
	if tile_coordinates.y == 7 or tile_coordinates.y == 0:
		%Sprite.play("attack_right")
	if tile_coordinates.y == 1 or tile_coordinates.y == 2:
		%Sprite.play("attack_back")
	if tile_coordinates.y == 3 or tile_coordinates.y == 4:
		%Sprite.play("attack_left")
	if tile_coordinates.y == 5 or tile_coordinates.y == 6:
		%Sprite.play("attack_front")
	await %Sprite.animation_finished

func play_enemy_sound(sound: String):
	match sound:
		"attack":
			match enemy_type:
				"ghost":
					SFX.play(SFX.Id.GHOST_ATTACK)
				"golem":
					SFX.play(SFX.Id.GOLEM_ATTACK)
				"mushroom":
					SFX.play(SFX.Id.MUSHROOM_ATTACK)
				"goblin":
					SFX.play(SFX.Id.GOBLIN_ATTACK)
				"snake":
					SFX.play(SFX.Id.SNAKE_ATTACK)
		"death":
			match enemy_type:
				"ghost":
					SFX.play(SFX.Id.GHOST_DEATH)
				"golem":
					SFX.play(SFX.Id.GOLEM_DEATH)
				"mushroom":
					SFX.play(SFX.Id.MUSHROOM_DEATH)
				"goblin":
					SFX.play(SFX.Id.GOBLIN_DEATH)
				"snake":
					SFX.play(SFX.Id.SNAKE_DEATH)
		"move":
			match enemy_type:
				"ghost":
					SFX.play(SFX.Id.GHOST_MOVE)
				"golem":
					SFX.play(SFX.Id.GOLEM_DEATH)
				"mushroom":
					SFX.play(SFX.Id.MUSHROOM_MOVE)
				"goblin":
					SFX.play(SFX.Id.GOBLIN_MOVE)
				"snake":
					SFX.play(SFX.Id.SNAKE_MOVE)
	
func highlight_attack():
	for attack in AttackPatterns.enemy_attack_patterns[enemy_type]:
		var v = (Vector2i)(attack)
		if tile_coordinates.x + v.x >= 0 and tile_coordinates.x + v.x <= 2:
			var new_y: int = tile_coordinates.y + v.y
			if new_y < 0:
				new_y = 8 + new_y
			new_y = new_y % 8
			LevelManager.toggle_enemy_attack_segment(tile_coordinates.x + v.x, new_y, true)

func _on_sprite_animation_finished() -> void:
	animation_finshed.emit()

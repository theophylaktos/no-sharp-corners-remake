extends DamageableObject

class_name Enemy

var is_attacking = false
var is_dying = false

@export var enemy_type: String = "":
	set(new_value):
		enemy_type = new_value
		update_type(enemy_type)
		
func update_type(type: String):
	%Sprite.sprite_frames = Constants.ENEMY_SPRITE_FRAMES[type]
	
func _ready() -> void:
	play_idle()
	
func play_idle():
	if not is_attacking and not is_dying:
		print(tile_coordinates.y)
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
	is_attacking = true
	if tile_coordinates.y == 7 or tile_coordinates.y == 0:
		%Sprite.play("attack_right")
	if tile_coordinates.y == 1 or tile_coordinates.y == 2:
		%Sprite.play("attack_back")
	if tile_coordinates.y == 3 or tile_coordinates.y == 4:
		%Sprite.play("attack_left")
	if tile_coordinates.y == 5 or tile_coordinates.y == 6:
		%Sprite.play("attack_front")
	await %Sprite.animation_finished
	is_attacking = false

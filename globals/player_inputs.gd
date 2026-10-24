extends Node

signal left_pressed
signal right_pressed
signal up_pressed
signal down_pressed

@warning_ignore("unused_signal")
signal first_attack_pressed
@warning_ignore("unused_signal")
signal second_attack_pressed
@warning_ignore("unused_signal")
signal third_attack_pressed

signal debug_pressed

var accepting_input: bool = true

func _process(_delta: float) -> void:
	if accepting_input == false:
		return
	if Input.is_action_just_pressed("left"):
		left_pressed.emit()
	if Input.is_action_just_pressed("right"):
		right_pressed.emit()
	if Input.is_action_just_pressed("up"):
		up_pressed.emit()
	if Input.is_action_just_pressed("down"):
		down_pressed.emit()
	if Input.is_action_just_pressed("debug"):
		print()
		print(LevelManager.object_tile_coordinates[0])
		print(LevelManager.object_tile_coordinates[1])
		print(LevelManager.object_tile_coordinates[2])
		print() 
		debug_pressed.emit()

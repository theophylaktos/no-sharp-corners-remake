extends Node

@export var phase = "player_move"

signal player_move_left_pressed
signal player_move_right_pressed
signal player_move_up_pressed
signal player_move_down_pressed


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		player_move_left_pressed.emit()
	if Input.is_action_just_pressed("right"):
		player_move_right_pressed.emit()
	if Input.is_action_just_pressed("up"):
		player_move_up_pressed.emit()
	if Input.is_action_just_pressed("down"):
		player_move_down_pressed.emit()
	await get_tree().create_timer(0.05).timeout

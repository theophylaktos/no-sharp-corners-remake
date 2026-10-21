extends Node

signal left_pressed
signal right_pressed
signal up_pressed
signal down_pressed


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		left_pressed.emit()
	if Input.is_action_just_pressed("right"):
		right_pressed.emit()
	if Input.is_action_just_pressed("up"):
		up_pressed.emit()
	if Input.is_action_just_pressed("down"):
		down_pressed.emit()

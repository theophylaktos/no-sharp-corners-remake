extends Node

var current_round: int = 0

var attacks: Array[String] = ["attack", "attack_two", ""]

signal moves_max_changed
var moves_max: int = 3:
	set(new_value):
		moves_max = new_value
		moves_max_changed.emit()
		
signal attacks_max_changed
var attacks_max: int = 1:
	set(new_value):
		attacks_max = new_value
		attacks_max_changed.emit()
		
signal health_max_changed
var health_max: int = 3:
	set(new_value):
		health_max = new_value
		health_max_changed.emit()
		
signal health_changed
@onready var health_left = GameState.health_max:
	set(new_value):
		health_changed.emit()
		health_left = new_value

var player_damage: int = 1

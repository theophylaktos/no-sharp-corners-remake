extends Node

@export var attack_patterns: Dictionary[String, Array] = {
	"attack": [Vector2i(1, 0)],
	"attack2": [Vector2i(2, 0)],
	"attack4": [Vector2(4, 0)],
	"all_horizontals": [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)],
	"all_diagonals": [Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1)],
	"attack_diagonal": [Vector2i(1, -1), Vector2i(1, 1)]
}

extends Node

@export var player_attack_patterns: Dictionary[String, Array] = {
	"": [],
	"attack": [Vector2i(1, 0)],
	"attack2": [Vector2i(2, 0)],
	"attack4": [Vector2(4, 0)],
	"all_horizontals": [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)],
	"all_diagonals": [Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1)],
	"attack_diagonal": [Vector2i(1, -1), Vector2i(1, 1)]
}

@export var enemy_attack_patterns: Dictionary[String, Array] = {
	"" = [],
	"ghost" = [Vector2i(0,2), Vector2i(2,0), Vector2i(0,-2), Vector2i(-2,0), Vector2i(1,1), Vector2i(1,-1), Vector2i(-1,1), Vector2i(-1,-1)],
	"goblin" = [Vector2i(1,1), Vector2i(1,-1), Vector2i(-1,1), Vector2i(-1,-1)],
	"mushroom" = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)],
	"golem" = [Vector2i(1,1), Vector2i(1,-1), Vector2i(-1,1), Vector2i(-1,-1), Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)],
	"snake" = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1), Vector2i(2,0), Vector2i(-2,0), Vector2i(0,2), Vector2i(0,-2)],
}

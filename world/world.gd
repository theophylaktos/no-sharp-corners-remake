extends Node2D

func _ready() -> void:
	RoundManager.world = self
	LevelManager.ring_zero = $Level/SubViewport/Ring0
	LevelManager.ring_one = $Level/SubViewport/Ring1
	LevelManager.ring_two = $Level/SubViewport/Ring2

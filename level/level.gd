extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $SubViewport/Ring0.get_child_count():
		LevelManager.segments[0][i] = $SubViewport/Ring0.get_child(i)
	for i in $SubViewport/Ring1.get_child_count():
		LevelManager.segments[1][i] = $SubViewport/Ring1.get_child(i)
	for i in $SubViewport/Ring2.get_child_count():
		LevelManager.segments[2][i] = $SubViewport/Ring2.get_child(i)

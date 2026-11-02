extends Node

@export var rounds: Dictionary[int, Array] = {
	0: ["mushroom", "mushroom"],
	1: ["golem", "goblin", "goblin"],
	2: ["goblin", "goblin", "golem", "golem"],
	3: ["golem", "goblin", "goblin", "snake"],
	4: ["golem", "golem", "snake", "snake"],
	5: ["golem", "ghost", "snake"],
	6: ["mushroom", "mushroom", "snake"],
	7: ["golem", "golem", "golem", "golem", "golem"],
	8: ["ghost", "ghost", "ghost"],
	9: ["golem", "golem", "golem", "goblin", "goblin", "snake"],
	10: ["ghost", "ghost", "mushroom", "mushroom", "snake"],
}

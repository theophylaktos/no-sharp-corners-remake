extends Node

const DISTANCES: Array[int] = [57, 39, 25]

const RING_SIZE: int = 2
const DEGREE_SIZE: int = 7

const ROTATE_TIME: float = 0.25

const HEART_ICON = preload("uid://csx7htciqrpvj")
const MOVE_ICON = preload("uid://yoxa5u2nhrm")
const ATTACK_ICON = preload("uid://b5je2lv2vomea")

const WEAPON_SPRITES: Dictionary[String, CompressedTexture2D] = {
	"diagonal": preload("uid://d30hood7b3jia"),
	"attack2": preload("uid://bwn8ypto7o7jl"),
	"attack4": preload("uid://ddlottmvshgpf"),
	"knight": preload("uid://c2hshq4wc3crf"),
	"all_diagonals": preload("uid://cskr21f181ur"),
	"all_horizontals": preload("uid://cop404wtgqx3h"),
	"attack": preload("uid://b7ptnpwn3k0ni"),
}

const ENEMY_SPRITE_FRAMES: Dictionary[String, SpriteFrames] = {
	"ghost" = preload("uid://cwxc8u76umgke"),
	"goblin" = preload("uid://bcf6pcwo58syt"),
	"golem" = preload("uid://o0w6ckpt3wq7"),
	"mushroom" = preload("uid://cmpkqlaa6epby"),
	"snake" = preload("uid://cqp6boq1d4t01"),
}

const ENEMY_HEALTH: Dictionary[String, int] = {
	"ghost" = 1,
	"goblin" = 2,
	"golem" = 2,
	"mushroom" = 2,
	"snake" = 2,
}

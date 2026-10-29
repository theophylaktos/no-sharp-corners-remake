extends Node

const DISTANCES: Array[int] = [57, 39, 25]

const RING_SIZE: int = 2
const DEGREE_SIZE: int = 7

const ROTATE_TIME: float = 0.25

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

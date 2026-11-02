extends Control
var shop: Array[String]
## array of strings that corrospond to upgrades
var items_had: Array[bool]

var replaced: int=2

var choice: int=0

var choices: Array[int]

## array of valid items to sell in a shop: valid=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	%FirstSlot.material.set_shader_parameter("is_outlined", true)
	%SecondSlot.material.set_shader_parameter("is_outlined", false)
	%ThirdSlot.material.set_shader_parameter("is_outlined", false)
	
	%FirstOption.material.set_shader_parameter("is_outlined", true)
	%SecondOption.material.set_shader_parameter("is_outlined", false)
	%ThirdOption.material.set_shader_parameter("is_outlined", false)
	
	shop.resize(12)
	items_had.resize(12)
	shop[0]="heal_two"
	shop[1]="add_heart"
	shop[2]="add_attack"
	shop[3]="more_damage"
	shop[4]="add_move"
	shop[5]="diagonal"
	shop[6]="attack_two"
	shop[7]="attack_four"
	shop[8]="knight"
	shop[9]="all_diagonals"
	shop[10]="all_horizontals"
	shop[11]="attack"
	items_had[11] = true
	
	choices = pick_three_valid()
	
	if GameState.attacks[0] != "":
		%FirstSlot.texture_normal = Constants.ITEM_SPRITES[GameState.attacks[0]]
	else:
		%FirstSlot.texture_normal = Constants.ITEM_SPRITES[""]
	if GameState.attacks[1] != "":
		%SecondSlot.texture_normal = Constants.ITEM_SPRITES[GameState.attacks[1]]
	else:
		%SecondSlot.texture_normal = Constants.ITEM_SPRITES[""]
	if GameState.attacks[2] != "":
		%ThirdSlot.texture_normal = Constants.ITEM_SPRITES[GameState.attacks[2]]
	else:
		%ThirdSlot.texture_normal = Constants.ITEM_SPRITES[""]
	var options: Array[int] = [0,1,2]
	print(options)
	if Constants.ITEM_SPRITES[shop[options[0]]] != null:
		%FirstOption.texture_normal = Constants.ITEM_SPRITES[shop[choices[0]]]
	if Constants.ITEM_SPRITES[shop[options[1]]] != null:
		%SecondOption.texture_normal = Constants.ITEM_SPRITES[shop[choices[1]]]
	if Constants.ITEM_SPRITES[shop[options[2]]] != null:
		%ThirdOption.texture_normal = Constants.ITEM_SPRITES[shop[choices[2]]]

func pick_three_valid() -> Array[int]:
	if(GameState.current_round < 2):
		return [6,7,8]
	var options: Array[int]
	options.resize(3)
	var possibility: int=0
	var pos: int = 0
	var already_sold: Array[bool]
	already_sold.resize(12)
	if(GameState.health_left<GameState.max_health):
		options[0]=0
		possibility+=1
		pos+=1
	for value in items_had:
		if(value==false):
			possibility+=1
	if(possibility<4):
		print("Out of stock!")
		return options
	var current: int
	while pos<3:
		current = randi_range(0,11)
		if(items_had[current] == false and (current!=0 or GameState.health_left != GameState.max_health) and already_sold[current]==false):
				options[pos]=current
				pos+=1
				already_sold[current]=true
	return options

func give_item():
	var is_removed: bool
	if(choice==0):
		is_removed=false
	elif(choice==1 && GameState.health_max<=7):
		is_removed=false
	elif(choice==2 && GameState.attacks_max<=3):
		is_removed=false
	elif(choice==4 && GameState.moves_max<=5):
		is_removed=false
	else:
		is_removed=true
	if(is_removed):
		items_had[choice]=true
	if(choice>=5):
		if(GameState.attacks[replaced]!=""):
			for attack in shop.size():
				if(shop[attack]==GameState.attacks[replaced]):
					items_had[attack]=false
					
	match choices[choice]:
		0:
			GameState.health_left+=2
			if(GameState.health_left>GameState.max_health):
				GameState.health_left=GameState.max_health
		1:
			GameState.max_health+=1
		2:
			GameState.max_attacks += 1
		3:
			GameState.damage*=2
		4:
			GameState.max_moves+=1
		5:
			GameState.attacks[replaced] = shop[choices[choice]]
		6:
			GameState.attacks[replaced] = shop[choices[choice]]
		7:
			GameState.attacks[replaced] = shop[choices[choice]]
		8:
			GameState.attacks[replaced] = shop[choices[choice]]
		9:
			GameState.attacks[replaced] = shop[choices[choice]]
		10:
			GameState.attacks[replaced] = shop[choices[choice]]
		11:
			print("hi")
			GameState.attacks[replaced] = shop[choices[choice]]


func _on_exit_button_pressed() -> void:
	give_item()
	get_tree().change_scene_to_file("uid://cvhhrs1oj6hcn")


func _on_first_slot_pressed() -> void:
	replaced = 0
	%FirstSlot.material.set_shader_parameter("is_outlined", true)
	%SecondSlot.material.set_shader_parameter("is_outlined", false)
	%ThirdSlot.material.set_shader_parameter("is_outlined", false)
	play_sound_on_item_clicked(shop.find(GameState.attacks[replaced]))


func _on_second_slot_pressed() -> void:
	replaced=1
	%FirstSlot.material.set_shader_parameter("is_outlined", false)
	%SecondSlot.material.set_shader_parameter("is_outlined", true)
	%ThirdSlot.material.set_shader_parameter("is_outlined", false)
	play_sound_on_item_clicked(shop.find(GameState.attacks[replaced]))


func _on_third_slot_pressed() -> void:
	replaced = 2
	%FirstSlot.material.set_shader_parameter("is_outlined", false)
	%SecondSlot.material.set_shader_parameter("is_outlined", false)
	%ThirdSlot.material.set_shader_parameter("is_outlined", true)
	play_sound_on_item_clicked(shop.find(GameState.attacks[replaced]))


func _on_first_option_pressed() -> void:
	choice = 0
	%FirstOption.material.set_shader_parameter("is_outlined", true)
	%SecondOption.material.set_shader_parameter("is_outlined", false)
	%ThirdOption.material.set_shader_parameter("is_outlined", false)
	
	play_sound_on_item_clicked(choices[choice])

func _on_second_option_pressed() -> void:
	choice = 1
	%FirstOption.material.set_shader_parameter("is_outlined", false)
	%SecondOption.material.set_shader_parameter("is_outlined", true)
	%ThirdOption.material.set_shader_parameter("is_outlined", false)

	play_sound_on_item_clicked(choices[choice])

func _on_third_option_pressed() -> void:
	choice = 2
	%FirstOption.material.set_shader_parameter("is_outlined", false)
	%SecondOption.material.set_shader_parameter("is_outlined", false)
	%ThirdOption.material.set_shader_parameter("is_outlined", true)
	
	play_sound_on_item_clicked(choices[choice])

func play_sound_on_item_clicked(item: int) -> void:
	if [0, 1, 2, 3, 4].has(item):
		SFX.play(SFX.Id.GLASS_TAP)
	if [6, 5, 9, 10, 11].has(item):
		SFX.play(SFX.Id.METAL_TAP)
	if [7, 8].has(item):
		SFX.play(SFX.Id.WOOD)
	else:
		SFX.play(SFX.Id.WOOD)

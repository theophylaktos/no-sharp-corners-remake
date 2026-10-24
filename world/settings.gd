extends Control

func _ready():
	visible = false
	
	$MasterSlider.value = GlobalSettings.master_volume
	$MusicSlider.value = GlobalSettings.music_volume
	$SFXSlider.value = GlobalSettings.sfx_volume
	
	change_bus_volume("Master", GlobalSettings.master_volume)
	change_bus_volume("Music", GlobalSettings.music_volume)
	change_bus_volume("SFX", GlobalSettings.sfx_volume)
	
func _on_master_h_slider_value_changed(value):
	change_bus_volume("Master", value)

func _on_music_h_slider_value_changed(value):
	change_bus_volume("Music", value)

func _on_sfx_h_slider_value_changed(value):
	change_bus_volume("SFX", value)

func change_bus_volume(bus, linear_value):
	if bus == "Master":
		GlobalSettings.master_volume = linear_value
	if bus == "Music":
		GlobalSettings.music_volume = linear_value
	if bus == "SFX":
		GlobalSettings.sfx_volume = linear_value
	if bus == "Ambience":
		GlobalSettings.ambience_volume = linear_value
	
	var db_value = linear_to_db(linear_value)
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, db_value)
	
func _on_close_button_pressed() -> void:
	visible = false
	PlayerInputs.accepting_input = false
	
func _on_exit_button_pressed() -> void:
	pass
	#RoundManager.change_scene_to_menu()

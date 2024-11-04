class_name MainMenu
extends Control

@onready var play_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var start_game = preload("res://scenes/escenarios/stage_1_2.tscn") as PackedScene
@onready var game_save_manager = get_node("res://scripts/game_save/GameSaveManager.gd")
@onready var player = get_node("res://scenes/personajes/patricio.tscn")

func _ready():
	play_button.button_down.connect(on_play_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	
func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func on_exit_pressed() -> void:
	get_tree().quit()


func _on_load_button_pressed() -> void:
	GlobalTimer.start()
	# Load the PackedScene resource
	var metadata = GameSaveManager.load_game()
	GlobalTimer.time = metadata["time"]
	Lifecounter.lives = metadata["lives"]
	Lifecounter.current_health = metadata["barra"]
	
	# Instance the scene
	var packed_scene = load("res://game_save.tscn")
	var my_scene = packed_scene
	
	get_tree().change_scene_to_packed(my_scene)
	
	if metadata["name"] != "stage":
		Lifecounter.plankton_health = metadata["barra-plankton"]

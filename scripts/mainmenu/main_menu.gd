class_name MainMenu
extends Control

@onready var play_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var start_game = preload("res://scenes/escenarios/stage_1_2.tscn") as PackedScene


func _ready():
	play_button.button_down.connect(on_play_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	
func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func on_exit_pressed() -> void:
	get_tree().quit()

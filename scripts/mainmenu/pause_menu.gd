extends Control

@onready var game_save_manager = get_node("res://scripts/game_save/GameSaveManager.gd")
@onready var player = get_node("res://scenes/personajes/patricio.tscn")
@export var game_time = 0 

var main_menu_scene = preload("res://scenes/mainmenu/main_menu.tscn")

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("menu_esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("menu_esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_save_pressed():
	game_save_manager.save_game(player, game_time)

func _on_exit_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/mainmenu/main_menu.tscn")
	GlobalTimer.reset()


func _process(delta):
	testEsc()

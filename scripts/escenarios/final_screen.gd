extends Control

@onready var label_2: Label = $Label2
@onready var lives: Lives = %Lives
@onready var pause_menu: Control = %PauseMenu
@onready var losing_screen: Control = %"Losing-screen"

func print_score():
	visible=true
	pause_menu.queue_free()
	losing_screen.queue_free()
	visible = true
	var score = int(30 * 60 - min(30 * 60, GlobalTimer.time)) * 5 * (Lifecounter.lives * lives.healthbar.max_value + lives.healthbar.value) + 20000
	
	label_2.text = "Your score is: " + str(score)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu/main_menu.tscn")

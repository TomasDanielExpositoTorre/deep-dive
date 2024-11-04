extends Control


@onready var pause_menu: Control = %PauseMenu
@onready var final_screen: Control = %"Final-screen"

func print_score():
	visible=true
	pause_menu.queue_free()
	final_screen.queue_free()
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu/main_menu.tscn")

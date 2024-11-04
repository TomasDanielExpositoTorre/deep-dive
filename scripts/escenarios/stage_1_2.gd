
extends Node2D

@onready var chests: Array = [$chest, $chest2, $chest3]  
@onready var llave: StaticBody2D = $Fixed/llave
@onready var GameSaveManager = $GameSaveManager

#var main_menu_scene = preload("res://scenes/mainmenu/main_menu.tscn") as PackedScene  #
#var main_menu_instance: Control = null  

func _ready():
	randomize()  
	set_random_key_chest()
	connect_signals()  

func connect_signals():
	for chest in chests:
		chest.connect("key_found", Callable(self, "_on_key_found"))

func set_random_key_chest():
	var key_chest_index = randi() % chests.size()  
	for i in range(chests.size()):
		if i == key_chest_index:
			chests[i].is_key_chest = true  
		else:
			chests[i].is_key_chest = false

func _on_key_found():
	llave.get_node("AnimatedSprite2D").visible = true
	llave.get_node("AnimatedSprite2D").play("llave")  
	

func _on_save_button_pressed():
	var save_data = {
		"player": $Player.get_save_data()
	}
	GameSaveManager.save_game(save_data)

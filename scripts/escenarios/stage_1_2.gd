
extends Node2D

@onready var chests: Array = [$chest, $chest2, $chest3]  
@onready var llave: StaticBody2D = $Fixed/llave


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
	
#func _input(event):
	#if Input.is_action_just_pressed("menu_esc"): 
		#if main_menu_instance == null:
			#show_main_menu() 
		#else:
			#hide_main_menu()  
#
#func show_main_menu():
	#main_menu_instance = main_menu_scene.instantiate()  
	#add_child(main_menu_instance) 
	#get_tree().paused = true  
	#get_tree().change_scene_to_file("res://scenes/mainmenu/main_menu.tscn")
#func hide_main_menu():
	#if main_menu_instance:
		#main_menu_instance.queue_free()  
		#main_menu_instance = null 
		#get_tree().paused = false 

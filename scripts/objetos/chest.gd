# Chest.gd
extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $DetectionArea

var is_key_chest: bool = false  

signal key_found()  

func _ready():
	animated_sprite.play("chest_vacio")  

func _on_detection_area_body_entered(body):
	if body.name == "Patricio":  
		play_chest_animation()

func play_chest_animation():
	if is_key_chest:
		animated_sprite.play("chest_lleno")
		emit_signal("key_found") 
	else:
		animated_sprite.play("chest_vacio")

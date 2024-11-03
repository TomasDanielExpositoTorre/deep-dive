extends StaticBody2D

@onready var puerta_cerrada_sprite: AnimatedSprite2D = $puerta_cerrada
@onready var puerta_abierta_sprite: AnimatedSprite2D = $puerta_abierta
@onready var detection_area: Area2D = $DetectionArea
@onready var collision_puerta_cerrada: CollisionShape2D = $Collision_puerta_cerrada
@onready var collision_detection_area: CollisionShape2D = $DetectionArea/CollisiondetectionArea

func _ready():
	#door closed by default
	puerta_cerrada_sprite.visible = true
	puerta_abierta_sprite.visible = false
	puerta_cerrada_sprite.play("puerta_cerrada")
	collision_puerta_cerrada.disabled = true 

func _on_detection_area_body_entered(body):
	if body.name == "Patricio":
		open_door()

func _on_detection_area_body_exited(body):
	if body.name == "Patricio":
		close_door()

func open_door():
	
	puerta_cerrada_sprite.visible = false
	puerta_abierta_sprite.visible = true
	puerta_abierta_sprite.play("puerta_abierta")
	collision_puerta_cerrada.disabled = true

func close_door():
	
	puerta_cerrada_sprite.visible = true
	puerta_abierta_sprite.visible = false
	puerta_cerrada_sprite.play("puerta_cerrada")
	collision_puerta_cerrada.disabled = false

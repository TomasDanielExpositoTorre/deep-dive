
extends StaticBody2D 

@onready var puerta_cerrada_sprite: AnimatedSprite2D = $puerta_cerrada
@onready var puerta_abierta_sprite: AnimatedSprite2D = $puerta_abierta
@onready var detection_area: Area2D = $DetectionArea
@onready var collision_puerta_cerrada: CollisionShape2D = $Collision_puerta_cerrada
@onready var collision_detection_area: CollisionShape2D = $DetectionArea/CollisiondetectionArea

var has_key: bool = false 

func _ready():
	# Door closed by default
	puerta_cerrada_sprite.visible = true
	puerta_abierta_sprite.visible = false
	puerta_cerrada_sprite.play("puerta_cerrada")
	collision_puerta_cerrada.disabled = false  
	print("Door is initialized as closed with collision enabled.")

	
	var chests = [get_node("../chest"), get_node("../chest2"), get_node("../chest3")]
	for chest in chests:
		if chest:
			chest.connect("key_found", Callable(self, "_on_key_found"))

func _on_detection_area_body_entered(body):
	if body.name == "Patricio" and has_key:
		open_door()  
		collision_puerta_cerrada.disabled = true 

func _on_detection_area_body_exited(body):
	if body.name == "Patricio":
		close_door()

func _on_key_found():
	has_key = true  
	print("Player has found the key! Door can now be opened.")

func open_door():
	puerta_cerrada_sprite.visible = false
	puerta_abierta_sprite.visible = true
	puerta_abierta_sprite.play("puerta_abierta")
	collision_puerta_cerrada.disabled = true 
	collision_detection_area.disabled = true
	print("Door opened, collision disabled.")

func close_door():
	puerta_cerrada_sprite.visible = true
	puerta_abierta_sprite.visible = false
	puerta_cerrada_sprite.play("puerta_cerrada")
	collision_puerta_cerrada.disabled = true 
	print("Door closed, collision enabled.")

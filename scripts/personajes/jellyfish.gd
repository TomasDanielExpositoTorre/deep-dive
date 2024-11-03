extends Node2D

"""
Class values
"""
const SPEED = 250
var direction = 1
var player = null
var player_detected = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

"""
Class functions
"""
func _process(delta: float) -> void:
	"""
	Handle collisions and movement.
	"""
	
	# Switch direction on hit wall layer
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.rotation_degrees = 300
	elif ray_cast_left.is_colliding():
		direction = 1
		sprite.rotation_degrees = 45
	
	# Determine movement speed
	if sprite.animation != "attack-buildup" and player_detected:
		position.x += (direction * SPEED * delta * 1.6)
	else:
		position.x += (direction * SPEED * delta)


func _on_detection_area_body_entered(body: Node2D) -> void:
	""" 
	Detect player and prepare attack
	"""
	player = body
	player_detected = true
	
	direction = -1 if player.position.x < position.x else 1
	sprite.rotation_degrees = 300 if direction == -1 else 45
	
	sprite.play("attack-buildup")

func _on_detection_area_body_exited(_body: Node2D) -> void:
	""" 
	Stop player detection
	"""
	player = null
	player_detected = false
	sprite.play("idle")


func _on_animation_finished() -> void:
	if sprite.animation == "attack-buildup" and player_detected:
		sprite.play("attack")


func _on_body_entered(body) -> void:
	body.remove_health()

extends Node2D

"""
Class values
"""
const SPEED = 130
var direction = 1
var player = null
var player_detected = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var body: CollisionShape2D = $CollisionShape2D

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var sight: CollisionShape2D = $"Detection Area/Sight"

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
		body.rotation_degrees = 300
		sight.position.x = -950
	elif ray_cast_left.is_colliding():
		direction = 1
		sprite.rotation_degrees = 45
		body.rotation_degrees = 45
		sight.position.x = 950
	
	# Determine movement speed
	if sprite.animation != "attack-buildup" and player_detected:
		position.x += (direction * SPEED * delta * 3)
	else:
		position.x += (direction * SPEED * delta)


func _on_detection_area_body_entered(body: Node2D) -> void:
	""" 
	Detect player and prepare attack
	"""
	player = body
	player_detected = true
	sprite.play("attack-buildup")

func _on_detection_area_body_exited(body: Node2D) -> void:
	""" 
	Stop player detection
	"""
	player = null
	player_detected = false
	sprite.play("idle")


func _on_animation_finished() -> void:
	if sprite.animation == "attack-buildup" and player_detected:
		sprite.play("attack")


func _on_body_entered(body: Player) -> void:
	body.remove_health()

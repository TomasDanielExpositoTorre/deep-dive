extends CharacterBody2D

@export var speed = 200 
@export var attack_range = 300.0  
var player_chase = false
var player = null
var direction_vector: Vector2 = Vector2.ZERO  # Declare direction_vector as a class variable

@export var rotation_speed: float = 5.0  # Controls the smoothness of rotation
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2

func _physics_process(delta):
	if player_chase:
		chase(delta)
		tiburonAnimation(delta)
	else:
		animated_sprite.play("tiburonSwim")  # Idle animation when not chasing

func chase(delta):
	# Calculate the direction towards the player
	direction_vector = (player.position - position).normalized()
	position += direction_vector * speed * delta

func tiburonAnimation(delta):
	# Determine the current distance to the player
	var distance_to_player = player.position.distance_to(position) if player else float("inf")

	# Choose the animation based on the distance
	if distance_to_player <= attack_range:
		# Within attack range, play the attack animation
		animated_sprite.play("tiburonAttack")
	else:
		# Outside of attack range, play the swimming animation
		animated_sprite.play("tiburonSwim")

	# Calculate the target rotation based on direction
	var target_rotation: float = 0

	# Determine if moving left or right and set `flip_h`
	if abs(direction_vector.x) > abs(direction_vector.y):
		# Horizontal movement (left or right)
		if direction_vector.x > 0:
			animated_sprite.flip_h = false  # Facing right
		else:
			animated_sprite.flip_h = true  # Facing left
	else:
		# Vertical or diagonal movement (up or down)
		if direction_vector.y > 0:
			# Moving downward
			target_rotation = 45 if !animated_sprite.flip_h else -45
		elif direction_vector.y < 0:
			# Moving upward
			target_rotation = -45 if !animated_sprite.flip_h else 45

	# Smoothly interpolate to the target rotation
	animated_sprite.rotation_degrees = lerp(animated_sprite.rotation_degrees, target_rotation, rotation_speed * delta)

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

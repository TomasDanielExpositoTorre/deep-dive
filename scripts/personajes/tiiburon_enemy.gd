extends CharacterBody2D

@export var speed = 200 
@export var chase_distance = 1000.0  # Distance at which the shark will start chasing
@export var attack_range = 200.0     # Range within which the shark attacks
@export var rotation_speed: float = 5.0  # Controls the smoothness of rotation

var player_chase = false
var player = null
var direction_vector: Vector2 = Vector2.ZERO  

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2

func _ready():
	# Find the player node, specifically "Patricio"
	player = get_parent().get_node_or_null("Patricio")
	if player:
		print("Patricio found:", player)
	else:
		print("Patricio not found")

func _physics_process(delta):
	if player:
		# Calculate the distance to Patricio
		var distance_to_player = player.position.distance_to(position)
		print("Distance to Patricio:", distance_to_player)

		if distance_to_player <= chase_distance:
			player_chase = true
			chase(delta)
			tiburonAnimation(distance_to_player, delta)
		else:
			player_chase = false
			animated_sprite.play("tiburonSwim")
	else:
		animated_sprite.play("tiburonSwim")

func chase(delta):
	# Calculate the direction towards Patricio and move
	direction_vector = (player.position - position).normalized()
	position += direction_vector * speed * delta
	print("Shark Position:", position)

func tiburonAnimation(distance_to_player, delta):
	# Choose the animation based on the distance to Patricio
	if distance_to_player <= attack_range:
		# Within attack range, play the attack animation
		animated_sprite.play("tiburonAttack")
		# Trigger damage or interaction with Patricio (if applicable)
		%Patricio.remove_health()
	else:
		# Outside of attack range, play the swimming animation
		animated_sprite.play("tiburonSwim")

	# Smooth rotation to face the player
	var target_rotation: float = 0
	if abs(direction_vector.x) > abs(direction_vector.y):
		if direction_vector.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		if direction_vector.y > 0:
			target_rotation = 45 if !animated_sprite.flip_h else -45
		elif direction_vector.y < 0:
			target_rotation = -45 if !animated_sprite.flip_h else 45

	animated_sprite.rotation_degrees = lerp(animated_sprite.rotation_degrees, target_rotation, rotation_speed * delta)

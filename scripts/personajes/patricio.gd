extends CharacterBody2D


const SPEED = 400.0
@onready var player_lives: Node2D = %PlayerLives
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	
	# Handle movement
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction.y:
		velocity.y = -direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if direction.x < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("spin")
	elif direction.x > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("spin")
	elif direction.y < 0:
		animated_sprite.play("down")
	elif direction.y > 0:
		animated_sprite.play("up")
	else:
		animated_sprite.play("idle")
		
	move_and_slide()


func _on_remove_health_pressed() -> void:
	player_lives.take_damage()


func _on_add_health_pressed() -> void:
	player_lives.heal_damage()

extends CharacterBody2D
class_name Player

"""
Class values
"""
const SPEED = 400.0
@onready var lives: Lives = %Lives
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


"""
Class functions
"""
func _physics_process(delta: float) -> void:
	"""
	Handle player movement
	"""
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	
	# Horizontal Movement
	if direction.x: 
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Vertical Movement
	if direction.y: 
		velocity.y = -direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	# Apply animations
	if direction.x < 0:
		sprite.flip_h = true
		sprite.play("spin")
	elif direction.x > 0:
		sprite.flip_h = false
		sprite.play("spin")
	elif direction.y < 0:
		sprite.play("down")
	elif direction.y > 0:
		sprite.play("up")
	else:
		sprite.play("idle")
		
	move_and_slide()


func remove_health():
	"""
	Take one damage.
	"""
	var tween = create_tween()
	tween.tween_property(sprite, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property(sprite, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
	lives.take_damage()
	
func restore_health():
	"""
	Heal one damage
	"""
	lives.heal_damage()

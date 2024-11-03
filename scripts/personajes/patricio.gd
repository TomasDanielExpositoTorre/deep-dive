extends CharacterBody2D

"""
Class values
"""
const SPEED = 400.0
var vulnerable := true

@onready var lives: Lives = %Lives
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var light: PointLight2D = $Light
@onready var darkness: CanvasModulate = %Darkness


"""
Class functions
"""
func _physics_process(delta: float) -> void:
	"""
	Handle player movement
	"""
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	
	if position.y < 7000:
		light.texture_scale = 0.25
		light.energy = 1
		darkness.color = Color(0.3, 0.3, 0.3, 1)
	elif position.y < 14000:
		light.texture_scale = 0.2
		light.energy = 0.85
		darkness.color = Color(0.22, 0.22, 0.22, 1)
	else:
		light.texture_scale = 0.15
		light.energy = 0.7
		darkness.color = Color(0.15, 0.15, 0.15, 1)
		
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
	if vulnerable:
		var tween = create_tween()
		tween.tween_property(sprite, "material:shader_parameter/amount", 1.0, 0.0)
		tween.tween_property(sprite, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
		lives.take_damage()
		vulnerable = false
		invincibility_timer.start()

func is_max_health():
	return lives.healthbar.value == lives.healthbar.max_value
	
func restore_health():
	"""
	Heal one damage
	"""
	lives.heal_damage()


func _on_invincibility_timer_timeout() -> void:
	vulnerable = true

extends CharacterBody2D

"""
Class values
"""
const SPEED = 400.0
var vulnerable := true

@onready var lives: Lives = %Lives
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var invincibility_timer: Timer = $InvincibilityTimer


"""
Class functions
"""
func _physics_process(delta: float) -> void:
	"""
	Handle player movement
	"""
	var direction := Input.get_axis("move_down", "move_up")

	# Vertical Movement
	if direction: 
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	sprite.play("machine gun")	
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
		
func restore_health():
	"""
	Heal one damage
	"""
	lives.heal_damage()


func _on_invincibility_timer_timeout() -> void:
	vulnerable = true

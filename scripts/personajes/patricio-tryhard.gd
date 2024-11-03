extends CharacterBody2D

"""
Class values
"""
const SPEED = 400.0
const SHOOT_FRAME_DURATION = 0.2
var vulnerable := true
var is_shooting = false

@onready var lives: Lives = %Lives
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var invincibility_timer: Timer = $InvincibilityTimer

@onready var bullet_path = preload("res://scenes/objetos/bullet.tscn")
@onready var frame_timer = Timer.new() 


"""
Class functions
"""


func _ready():
	add_child(frame_timer) 
	frame_timer.one_shot = true
	frame_timer.timeout.connect(_on_frame_timer_timeout)
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_down", "move_up")
	
	# Movimiento vertical
	if direction: 
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if Input.is_action_just_pressed("shoot"):
		disparar()
		
	move_and_slide()

func disparar():
	if is_shooting:
		return
	
	is_shooting = true 
	sprite.play("shooting")
	frame_timer.start(SHOOT_FRAME_DURATION) 
	
	var bullet = bullet_path.instantiate()
	bullet.velocity = Vector2(bullet.speed, 0)
	bullet.position = global_position + Vector2(50, 0)
	get_parent().add_child(bullet)
		
		
func _on_frame_timer_timeout():
	sprite.play("idle")
	is_shooting = false


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

func _on_invincibility_timer_timeout() -> void:
	vulnerable = true






	
#func take_damage():
	#health -= 1
	#if health <= 0:
		#queue_free()
#
#func _on_area_2d_area_entered(area):
	#take_damage()

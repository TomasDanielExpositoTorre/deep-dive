extends CharacterBody2D

const SPEED = 150
const SHOOT_INTERVAL = .7
const INITIAL_HEALTH = 40
const SHOOT_FRAME_DURATION = 0.2
var health = INITIAL_HEALTH
var direction = 1
var is_shooting = false
@onready var shooting_sound: AudioStreamPlayer2D = $Shooting

@onready var bullet_path = preload("res://scenes/objetos/bullet_plankton.tscn")
@onready var sprite = $AnimatedSprite2D
@onready var shoot_timer = Timer.new()
@onready var frame_timer = Timer.new() 
@onready var ray_cast_up: RayCast2D = $RayCastUP
@onready var ray_cast_down: RayCast2D = $RayCastDOWN
@onready var health_bar: ProgressBar = %"BossBar"
@onready var boss_name: TextEdit = %BossName
@onready var hurt: AudioStreamPlayer2D = $Hurt
@onready var dead: AudioStreamPlayer2D = $Dead


func _ready():
	shoot_timer.wait_time = SHOOT_INTERVAL
	add_child(shoot_timer)
	add_child(frame_timer) 
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shoot_timer.start()

	frame_timer.one_shot = true
	frame_timer.timeout.connect(_on_frame_timer_timeout)

	health_bar.max_value = INITIAL_HEALTH
	health_bar.value = health

func _physics_process(delta):
	
	if ray_cast_up.is_colliding():
		direction = 1
	if ray_cast_down.is_colliding():
		direction = -1
	
	velocity.y = direction * SPEED 

	
	move_and_slide()


func _on_shoot_timer_timeout():
	disparar()

func disparar():
	if is_shooting:
		return
	
	is_shooting = true 
	sprite.play("shooting")
	shooting_sound.play()
	frame_timer.start(SHOOT_FRAME_DURATION) 

	var bullet = bullet_path.instantiate()
	bullet.position = global_position - Vector2(50, 0)
	bullet.velocity = Vector2(-500, 0)
	get_parent().add_child(bullet)

func _on_frame_timer_timeout():
	sprite.play("idle")
	is_shooting = false

func remove_health():
	
	var tween = create_tween()
	tween.tween_property(sprite, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property(sprite, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)

	health -= 1
	health_bar.value = health 
	if health <= 0:
		health_bar.hide()
		boss_name.hide()
		dead.play()
		await get_tree().create_timer(2.1).timeout
		queue_free()
	else:
		hurt.play()

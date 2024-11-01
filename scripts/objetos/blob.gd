extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_attack_timer_timeout() -> void:
	self.z_index=0
	sprite.play("attack")
	await get_tree().create_timer(0.4).timeout
	collision.disabled = false
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "attack":
		self.z_index=-1
		collision.disabled = true
		sprite.play("idle")
		attack_timer.start()


func _on_body_entered(body: Node2D) -> void:
	body.remove_health()

# Almeja -Si hay perla suma vida, evento al azar.David

extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D
var perla
var target = position 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perla = randi_range(0, 1)

func _physics_process(_delta):

	
	target   = %Patricio.position
	target.x = %Patricio.position.x
	target.y = %Patricio.position.y
	
	if not %Patricio.is_max_health() and abs(target.x - position.x) < 30 && abs(target.y - position.y) < 30 && perla == 1:
		%Patricio.restore_health()
		$AnimatedSprite2D.play("vacia")
		perla = 0


func _on_body_entered(body: Node2D) -> void:
	if perla == 0:
		$AnimatedSprite2D.play("vacia")
	else:
		$AnimatedSprite2D.play("premio")


func _on_body_exited(body: Node2D) -> void:
		$AnimatedSprite2D.play("cerrada")
	

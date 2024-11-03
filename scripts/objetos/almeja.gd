# Almeja -Si hay perla suma vida, evento al azar.David

extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D
var perla

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	perla = randi_range(0, 1)
	
var target = position 

func _physics_process(_delta):

	
	target   = %Patricio.position
	target.x = %Patricio.position.x
	target.y = %Patricio.position.y
	$AnimatedSprite2D.play("Almeja cerrada")
	
	if target == position && perla == 1:
		
		$AnimatedSprite2D.play("Almeja con premio")
		%Patricio.restore_health()
		perla = 0
						
	else:	
			
		$AnimatedSprite2D.play("Almeja sin premio")

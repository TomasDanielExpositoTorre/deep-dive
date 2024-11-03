extends Area2D

@export var speed = 500
var velocity = Vector2.ZERO
	
func _process(delta):
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	body.remove_health()

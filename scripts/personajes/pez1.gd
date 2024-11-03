# PEZ PERSEGUIDOR NIVEL 1 - Davidas

extends CharacterBody2D

@export var speed = 100

var target = position 

func _physics_process(_delta):

	target   = %Patricio.position
	target.x = %Patricio.position.x
	target.y = %Patricio.position.y
		
	
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > 10:
		
			if position.x < target.x && target.x - position.x > 50:
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("idle")				
					
			else: if position.x < target.x && target.x - position.x < 50:	
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("girando")
										
			if position.x > target.x && position.x - target.x > 50:			
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("idle")				
				
			else: if position.x > target.x && position.x - target.x < 50:
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("girando")
						
			move_and_slide()	
	
	else:  if position.distance_to(target) < 10:
		
				if position.x < target.x:	
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("cabreado")
				if position.x > target.x:	
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("cabreado")
				%Patricio.remove_health()
		
				

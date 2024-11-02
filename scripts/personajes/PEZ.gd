# PEZ PERSEGUIDOR NIVEL 1 - David

extends CharacterBody2D

@export var speed = 200

var target = position 

func _physics_process(_delta):

	target   = %Patricio.position
	target.x = %Patricio.position.x
	target.y = %Patricio.position.y
		
	
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > 10:
		
			if position.x < target.x && target.x - position.x > 50:
					$AnimatedSprite2D.play("der")				
					
			else: if position.x < target.x && target.x - position.x < 50:	
					$AnimatedSprite2D.play("centrDI")
										
			if position.x > target.x && position.x - target.x > 50:			
					$AnimatedSprite2D.play("izq")			
				
			else: if position.x > target.x && position.x - target.x < 50:
					$AnimatedSprite2D.play("centrID")
						
			move_and_slide()	
	
	else:  if position.distance_to(target) < 10:
		
				if position.x < target.x:	
					$AnimatedSprite2D.play("dercbr")							
				if position.x > target.x:	
					$AnimatedSprite2D.play("izqcbr")

				%Patricio.remove_health()
				

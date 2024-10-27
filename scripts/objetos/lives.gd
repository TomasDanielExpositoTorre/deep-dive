extends Node

@onready var healthbar: ProgressBar = $Healthbar
@onready var live_1: Sprite2D = $Live1
@onready var live_2: Sprite2D = $Live2
@onready var live_3: Sprite2D = $Live3
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(3)

func set_health(h):
	healthbar.max_value = h
	healthbar.value = h
	healthbar.min_value = 0
	
func take_damage():
	healthbar.value = clamp(healthbar.value-1, healthbar.min_value, healthbar.max_value)
	
	if lives > 0 and healthbar.value == 0:
		lives -= 1
		healthbar.value = healthbar.max_value
	elif healthbar.value == 0:
		print("You lost the game my pana")
		
func heal_damage():
	healthbar.value = clamp(healthbar.value+1, healthbar.min_value, healthbar.max_value)
	
func _physics_process(delta: float):
	
	if lives == 2:
		live_3.hide()	
	if lives == 1:
		live_2.hide()	
	if lives == 0:
		live_1.hide()	

extends Node
class_name Lives
@onready var losing_screen: Control = %"Losing-screen"

"""
Class values
"""

@onready var healthbar: ProgressBar = $Healthbar
@onready var life_1: Sprite2D = $Life1
@onready var life_2: Sprite2D = $Life2
@onready var life_3: Sprite2D = $Life3
var printing_results = false

"""
Class functions
"""
func _ready() -> void:
	set_health(5)
	
func set_health(h):
	"""
	Sets number of hits per life in the health bar.
	"""
	healthbar.max_value = h
	healthbar.value = Lifecounter.current_health
	healthbar.min_value = 0
	
func take_damage():
	"""
	Takes one damage removes a life on an empty health bar.
	"""
	
	# Take damage
	healthbar.value = clamp(healthbar.value-1, healthbar.min_value, healthbar.max_value)
	
	# Reload scene maintaining number of lives
	if Lifecounter.lives > 0 and healthbar.value == 0:
		Lifecounter.lives -= 1
		healthbar.value = healthbar.max_value
		get_tree().reload_current_scene()
	# U is ded
	elif healthbar.value == 0 and printing_results == false:
		printing_results = true
		if get_tree().current_scene.name == "Stage1-2":
			get_tree().change_scene_to_file("res://scenes/escenarios/losing-screen2.tscn")
		else:
			losing_screen.print_score()
		
func heal_damage():
	"""
	Restores one health.
	"""
	healthbar.value = clamp(healthbar.value+1, healthbar.min_value, healthbar.max_value)
	
func _physics_process(delta: float):
	"""
	Hides life sprites as you lose them.
	"""
	if Lifecounter.lives == 2:
		life_3.hide()
	if Lifecounter.lives == 1:
		life_3.hide()
		life_2.hide()	
	if Lifecounter.lives == 0:
		life_3.hide()
		life_2.hide()
		life_1.hide()	

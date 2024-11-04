extends Node
var time = 0.0
var is_stopped = true

func _physics_process(delta: float) -> void:
	if is_stopped:
		return
	time += delta

func start():
	is_stopped = false
	
func stop():
	is_stopped = true
	
func reset():
	time = 0.0
	is_stopped = true
	

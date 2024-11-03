extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.start()


func _process(delta: float) -> void:
	var minutes = int(GlobalTimer.time) / 60
	var seconds = int(GlobalTimer.time) % 60
	var milliseconds = int((GlobalTimer.time - int(GlobalTimer.time)) * 100)
	# Actualiza el Label con el formato "MM:SS:MS"
	text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

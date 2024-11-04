extends Area2D
@onready var start_game = preload("res://scenes/escenarios/boss_fight.tscn") as PackedScene


func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_packed(start_game)

extends Node2D


func _on_Portal_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Level2.tscn")

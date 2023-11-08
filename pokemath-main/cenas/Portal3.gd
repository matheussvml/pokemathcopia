extends Node2D


func _on_Portal3_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Final.tscn")

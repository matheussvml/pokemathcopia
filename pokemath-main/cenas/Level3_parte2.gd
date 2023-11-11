extends Node2D


func _ready():
	$AudioStreamPlayer.play()


func _on_Area2D2_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Level2_parte2.tscn")

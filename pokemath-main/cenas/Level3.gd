extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


func _on_Area2D2_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Level2_parte2.tscn")

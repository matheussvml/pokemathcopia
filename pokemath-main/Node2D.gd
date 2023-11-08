extends Node2D

func _ready():
	$AnimationPlayer.play("inicio")
	$Intro.play()

func  _process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://cenas/CenaDentro.tscn")
		$Intro.stop()

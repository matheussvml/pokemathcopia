extends Node2D

func _ready():
	$Timer.start()
	$Menu_player.casaFora()
	
func _on_Button_pressed():
	get_tree().change_scene("res://cenas/Level1.tscn")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Cenas/Level1.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://Cenas/Level1.tscn")

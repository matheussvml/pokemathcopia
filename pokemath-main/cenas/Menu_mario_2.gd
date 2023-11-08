extends Node2D


func _ready():
	$Timer.start()
	$Timer2.start()
	$AnimationPlayer.play("dialogo")
	$Historia.play()


func _on_Button_pressed():
	get_tree().change_scene("res://Cenas/CenaFora.tscn")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Cenas/CenaFora.tscn")
		$Historia.stop()


func _on_Timer_timeout():
	$Menu_player.casaDentro()


func _on_Timer2_timeout():
	get_tree().change_scene("res://Cenas/CenaFora.tscn")

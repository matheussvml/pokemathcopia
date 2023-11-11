extends Node2D

onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")

export (int, "Pixels", "Spot_player", "Spot_centro", "Corte_vertical", "Corte_horizontal" ) var transition_type
export(float, 2.0) var duration = 1.0


func _ready():
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	$Transition.hide()
	$Final.play()


func _on_Area2D2_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Level3_parte2.tscn")


func _on_Boss_body_entered(body):
	if body is Player:
		$Timer.start()
		$Transition.show()
		animation.play("transition_in")
		get_tree().change_scene("res://cenas/battle_final.tscn")


func _on_Timer_timeout():
	$Transition.hide()

extends Node2D



onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")

export (int, "Pixels", "Spot_player", "Spot_centro", "Corte_vertical", "Corte_horizontal" ) var transition_type
export(float, 2.0) var duration = 1.0


func _ready():
	animation.play("transition_out")
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	$musicafim.play()
	$AnimationPlayer.play("final")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://cenas/Final.tscn")

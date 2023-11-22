extends Node2D

onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")

export (int, "Pixels", "Spot_player", "Spot_centro", "Corte_vertical", "Corte_horizontal" ) var transition_type
export(float, 2.0) var duration = 1.0

signal completou

func _ready():
	$Transition.hide()
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
#	$Player.connect("passou", self, "_on_Player_passou")
	$battle.hide()
	$MusicaFundo.play()


func _on_Area2D_body_entered(body):
	if body is Player:
		$Timer.start()
		$Transition.show()
		animation.play("transition_out")
		
		$inimigue2.hide()
		$battle.show()
		$MusicaFundo.stop()
		$MusicaBatalha.play()
		$Area2D/cacete.position.x = -23213


func _on_Area2D2_body_entered(body):
	if body is Player:
		emit_signal("completou")
		get_tree().change_scene("res://cenas/Level1_parte2.tscn")


func _on_Timer_timeout():
	$Transition.hide()




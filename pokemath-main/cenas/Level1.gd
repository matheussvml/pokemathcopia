extends Node2D

onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")

export (int, "Pixels", "Spot_player", "Spot_centro", "Corte_vertical", "Corte_horizontal" ) var transition_type
export(float, 2.0) var duration = 1.0

func _ready():
	$Transition.hide()
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	$MusicaFundo.play()
	$battle.hide()

func _on_Area2D2_body_entered(body):
	
	if body is Player:
		$Timer.start()
		$Transition.show()
		animation.play("transition_out")

		$MusicaFundo.stop()
		$MusicaBatalha.play()
		$battle.show()
		
#		if Global.fugir == true and State.fugir == true:
#			pass
#		else:
#			$Area2D2/CollisionShape2D.position.x = -321231



func _on_Timer_timeout():
	$Transition.hide()


func _on_battle_fugiu():
	$Area2D2/CollisionShape2D.position.x = 370


func _on_battle_fimbatalha():
	$Area2D2/CollisionShape2D.position.x = -321231
	$MusicaFundo.play()

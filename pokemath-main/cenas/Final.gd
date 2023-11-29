extends Node2D

onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")

export (int, "Pixels", "Spot_player", "Spot_centro", "Corte_vertical", "Corte_horizontal" ) var transition_type
export(float, 2.0) var duration = 1.0


func _ready():
	$battle.hide()
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	$Transition.hide()
	$Final.play()



func _on_Boss_body_entered(body):
	if body is Player:
		$Timer.start()
		$Transition.show()
		animation.play("transition_out")
		
		$battle.show()
		$Final.stop()
		$MusicaBoss.play()
		$Boss/CollisionShape2D.position.x = -23213
		


func _on_Timer_timeout():
	$Transition.hide()



extends Node2D



func _ready():
	$MusicaFundo.play()
	$battle.hide()


func _on_Area2D2_body_entered(body):
	if body is Player:
		$MusicaFundo.stop()
		$MusicaBatalha.play()
		$battle.show()
		$Area2D2/CollisionShape2D.position.x = -321231


extends Node2D



func _ready():
	$battle.hide()
	$MusicaFundo.play()


func _on_Area2D_body_entered(body):
	if body is Player:
		$battle.show()
		$MusicaFundo.stop()
		$MusicaBatalha.play()
		$Area2D/CollisionShape2D.position.x = -23213

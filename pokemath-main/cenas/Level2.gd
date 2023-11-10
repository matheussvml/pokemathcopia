extends Node2D



func _ready():
	$battle.hide()
	$MusicaFundo.play()


func _on_Area2D_body_entered(body):
	if body is Player:
		$inimigue2.hide()
		$battle.show()
		$MusicaFundo.stop()
		$MusicaBatalha.play()
		$Area2D/CollisionShape2D.position.x = -23213


func _on_Area2D2_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://cenas/Level1_parte2.tscn")

extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body is Player:
		yield(get_tree().create_timer(0.25), "timeout")
		$AnimationPlayer.play("transicao")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://cenas/battle1.tscn")

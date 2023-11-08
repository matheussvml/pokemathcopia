extends Node2D


func _ready():
	pass

func casaFora():
	$AnimationPlayer.play("CasaFora")

func casaDentro():
	$AnimationPlayer.play("casaDentro")

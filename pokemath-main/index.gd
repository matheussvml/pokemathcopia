extends Node


var index = 0



func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		index += 1
	
	if Input.is_action_just_pressed("ui_left"):
		index -= 1
	
	
	
	if Input.is_action_just_pressed("ui_accept"):
		pass

func _ready():
	pass 

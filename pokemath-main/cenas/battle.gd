extends Control

signal textbox_closed


func _ready():
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("O Algebrion apareceu!")
	yield(self, "textbox_closed")
	$ActionsPanel.show()

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")


func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text




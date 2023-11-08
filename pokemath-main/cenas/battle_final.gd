extends Control

export(Resource) var enemy = null

signal textbox_closed
var respostaCerta = 72
var current_player_health = 0
var current_enemy_health = 0
var is_defending = false

func _ready():
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, Global.current_health, Global.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = Global.current_health
	current_enemy_health = enemy.health
	#$ActionsPanel/Actions/Run.connect("pressed", self, "_on_Run_Pressed")
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("O %s apareceu!" % enemy.name.to_upper())
	yield(self, "textbox_closed")
	$ActionsPanel.show()

func set_health(progress_bar,health, max_health):
	progress_bar.value = health
	progress_bar.value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")


func display_text(text):
	$ActionsPanel.hide()
	$Textbox.show()
	$Textbox/Label.text = text





func _on_Run_pressed():
	#var respostaPlayer = $WindowDialog.text
	display_text("Resolva essa conta para fugir!")
	yield(self, "textbox_closed")
	display_text("9 x 8")
	yield(get_tree().create_timer(0.25), "timeout")
	#if respostaPlayer == respostaCerta:
	#	display_text("Parabens! Voce acertou poderá fugir")
	#else:
	#	display_text("Lamento, tente novamente")
	#	return _on_Run_pressed()
	
	yield(self, "textbox_closed")
	get_tree().change_scene("res://cenas/battle.tscn")

func _on_Defend_pressed():
	is_defending = true
	display_text("Voce escolheu esquiva!")
	yield(self, "textbox_closed")
	display_text("resolva essa multiplicacao para esquivar!")
	yield(self, "textbox_closed")
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	enemy_turn()

func enemy_turn():
	display_text("%s usa subtracao em voce!" % enemy.name)
	yield(self, "textbox_closed")
	
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("mini_shake")
		yield($AnimationPlayer, "animation_finished")
		display_text("Voce se esquivou com sucesso!")
		yield(self, "textbox_closed")
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, Global.max_health)
		$AnimationPlayer.play("shake")
		yield($AnimationPlayer, "animation_finished")
		display_text("%s deu %d de dano!" % [enemy.name,enemy.damage])
		yield(self, "textbox_closed")
	$ActionsPanel.show()

func _on_Attack_pressed():
	display_text("seu pokemon usou ataque de adicao!")
	yield(self, "textbox_closed")
	display_text("Resolva essa conta matematica para continuar!")
	yield(self, "textbox_closed")
	
	current_enemy_health = max(0, current_enemy_health - Global.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	yield($AnimationPlayer, "animation_finished")
	
	display_text("Voce deu %d de dano!" % Global.damage)
	yield(self, "textbox_closed")
	
	if current_enemy_health == 0:
		display_text("%s foi derrotado!!" % enemy.name)
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("enemy_defeated")
		yield($AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(0.35), "timeout")
		get_tree().change_scene("res://cenas/Menu_final.tscn")
	
	enemy_turn()

extends Control

signal textbox_closed

export(Resource) var enemy = null

var current_player_health = 0
var current_enemy_health = 0

var is_defending = false

func _ready():
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("Um %s apareceu!" % enemy.name.to_upper())
	yield(self, "textbox_closed")
	$ActionsPanel.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text


func _on_Run_pressed():
	display_text("Resolva essa multiplicacao para fugir!")
	yield(self, "textbox_closed")
	yield(get_tree().create_timer(0.25),"timeout")
	$".".hide()

func enemy_turn():
	display_text("%s usa o ataque da subtracao em voce!" % enemy.name)
	yield(self, "textbox_closed")
	
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("mini_shake")
		display_text("Voce esquivou com sucesso!")
		yield(self, "textbox_closed")
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("shake")
		yield($AnimationPlayer, "animation_finished")
		display_text("O %s deu %d de dano!" % [enemy.name, enemy.damage])
		yield(self, "textbox_closed")

	

func _on_Attack_pressed():
	display_text("Voce atacou usando o poder das adicoes!")
	yield(self, "textbox_closed")
	
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	yield($AnimationPlayer, "animation_finished")
	
	display_text("Voce deu %d de dano!" % State.damage)
	yield(self, "textbox_closed")
	
	if current_enemy_health == 0:
		display_text("O %s foi derrotado!" % enemy.name)
		yield(self, "textbox_closed")
		$AnimationPlayer.play("enemy_defeated")
		yield($AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(0.35),"timeout")
		$".".visible = false
		$"../MusicaBatalha".stop()
		$"../MusicaFundo".play()
	
	enemy_turn()


func _on_Defend_pressed():
	is_defending = true
	display_text("Resolva essa multiplicacao para se esquivar!")
	yield(self, "textbox_closed")
	
	yield(get_tree().create_timer(0.25),"timeout")
	
	enemy_turn()

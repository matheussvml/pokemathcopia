extends Control

signal pressed
signal textbox_closed

var index = 0
export(Resource) var enemy = null

var current_player_health = 0
var current_enemy_health = 0

var is_defending = false

func _ready():
#	var rng = RandomNumberGenerator.new()
#	var num1 = rng.randi_range(1, 50)
#	var num2 = rng.randi_range(1, 50)
#	$"Botoes/25".text = str(num1.randi_range(1, 25))
#	$"Botoes/35".text = str(num1+num2)
#	$"Botoes/45".text = str(num1.randi_range(1, 25))
#	$"Botoes/34".text = str(num2.randi_range(1, 25))
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	$Botoes.hide()
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

func gerar_operacoes(sinal):
	var rng = RandomNumberGenerator.new()
	var num1 = int(rng.randf_range(1, 10))
	var num2 = int(rng.randf_range(1, 10))
	return str(num1) + " " + sinal + " " + str(num2)

func _on_Run_pressed():
	display_text("Resolva essa multiplicacao para fugir!")
	yield(self, "textbox_closed")
	yield(get_tree().create_timer(0.25),"timeout")
	$".".hide()

func enemy_turn():
	$ActionsPanel.show()
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
	var rng = RandomNumberGenerator.new()
	randomize()
	var num1 = randi()%50
	randomize()
	var num2 = randi()%50
	
	randomize()
	var x = randi()%100 + 50
	randomize()
	var y = randi()%100 + 50

	var posicao = Vector2(x, y)
	
	$Botoes.rect_position.x = Vector2(x,y)
	$"Botoes/25".text = str(int(num1) + randi()%50)
	$"Botoes/34".text = str(int(num1) + randi()%50)
	$"Botoes/45".text = str(int(num1) + randi()%50)
	$"Botoes/35".text = str(int(num1) + int(num2))
	display_text("Voce atacou usando o poder das adicoes!")
	yield(self, "textbox_closed")
	display_text("Resolva essa adicao para atacar!")
	yield(self, "textbox_closed")
	display_text(gerar_operacoes("+"))
	display_text("%s + %d" % [int(num1), int(num2)])
#	yield(self, "textbox_closed")
	$Botoes.show()
	$ActionsPanel.hide()
#	current_enemy_health = max(0, current_enemy_health - State.damage)
#	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
#	$AnimationPlayer.play("enemy_damaged")
#	yield($AnimationPlayer, "animation_finished")
	
#	display_text("Voce deu %d de dano!" % State.damage)
#	yield(self, "textbox_closed")
	
#	if current_enemy_health == 0:
#		display_text("O %s foi derrotado!" % enemy.name)
#		yield(self, "textbox_closed")
#		$AnimationPlayer.play("enemy_defeated")
#		yield($AnimationPlayer, "animation_finished")
#		yield(get_tree().create_timer(0.35),"timeout")
#		$".".visible = false
#		$"../MusicaBatalha".stop()
#		$"../MusicaFundo".play()
	
#	enemy_turn()


func _on_Defend_pressed():
	is_defending = true
	var rng = RandomNumberGenerator.new()
	randomize()
	var num1 = randi()%50
	randomize()
	var num2 = randi()%50
	
	$"Botoes/25".text = str(int(num1) + randi()%50)
	$"Botoes/34".text = str(int(num1) + randi()%50)
	$"Botoes/45".text = str(int(num1) + randi()%50)
	$"Botoes/35".text = str(int(num1) + int(num2))
	
	display_text("Resolva essa multiplicacao para se esquivar!")
	yield(self, "textbox_closed")
	display_text("%s + %d" % [int(num1), int(num2)])
	$Botoes.show()



func _on_25_pressed():
	var rng = RandomNumberGenerator.new()
	var num1 = rng.randi_range(1, 10)
	var num2 = rng.randi_range(1, 10)
	$"Botoes/25".text = str(num1 + 3)
	$Botoes.hide()
	display_text("Infelizmente voce errou :(. O correto seria 35")
	yield(self, "textbox_closed")
	enemy_turn()


func _on_35_pressed():
	var rng = RandomNumberGenerator.new()
	var num1 = rng.randi_range(1, 50)
	var num2 = rng.randi_range(1, 50)
	$"Botoes/35".text = str(num1+num2)
	$Botoes.hide()
	display_text("Voce acertou!! Dano maximo")
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
		$Botoes.hide()
		
	enemy_turn()
	$ActionsPanel.show()


func _on_45_pressed():
	$Botoes.hide()
	display_text("Infelizmente voce errou :(. O correto seria 35")
	yield(self, "textbox_closed")
	enemy_turn()
	$ActionsPanel.show()

func _on_34_pressed():
	$Botoes.hide()
	display_text("Infelizmente voce errou :(. Chegou perto! O correto seria 35")
	yield(self, "textbox_closed")

	enemy_turn()
	$ActionsPanel.show()









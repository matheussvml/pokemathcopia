extends Control

signal fimbatalha8
signal fugiu
signal sucesso
signal failed
signal pressed
signal textbox_closed

var defendeu = false

var index = 0
var pergunta = [
	"2+2",
	"4x4",
	"6x4",
	"10+10+6",
	"9+8",
	"9x2"
]
var resposta = [
	4,
	16,
	24,
	26,
	17,
	18,
]
#posições
#posição1 300,367
#posição2 418,367
#posição3 535,367
#posição4 655, 367
var posicoes = [
	300,
	418,
	535,
	655
]
export(Resource) var enemy = null

var current_player_health = 0
var current_enemy_health = 0

var is_defending = false
var questao_atual = 0
var has_answered = false

func _ready():
	emit_signal("fugiu") == false
	Global.fugir = false
	State.fugir = false
	#$Options/Option1/Label.text = resposta[questao_atual]
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	$seta.hide()
	$Options.hide()
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

func update_cursor():
	$seta.position.x = posicoes[index]

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		index -= 1
		if index < 0:
			index = 0
		update_cursor()
	if Input.is_action_just_pressed("ui_right"):
		index += 1
		if index > 3:
			index = 3
		update_cursor()
	if Input.is_action_just_pressed("ui_accept"):
		check()
	

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text

func gerar_operacoes(sinal):
	var rng = RandomNumberGenerator.new()
	var num1 = int(rng.randf_range(1, 10))
	var num2 = int(rng.randf_range(1, 10))
	return str(num1) + " " + sinal + " " + str(num2)



func enemy_turn():
	$ActionsPanel.show()
	display_text("%s usa o ataque da subtracao em voce!" % enemy.name)
	yield(self, "textbox_closed")
	
	if is_defending == true and defendeu == true:
		is_defending = false
		current_player_health = max(0, current_player_health - 0)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("mini_shake")
		display_text("Voce esquivou com sucesso!")
		yield(self, "textbox_closed")
		defendeu = false
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("shake")
		yield($AnimationPlayer, "animation_finished")
		display_text("O %s deu %d de dano!" % [enemy.name, enemy.damage])
		yield(self, "textbox_closed")



func _on_Run_pressed():
	var rng = RandomNumberGenerator.new()
	randomize()
	var num1 = randi()%10
	randomize()
	var num2 = randi()%10 
	
	num2 != 0
	
	randomize()
	var x = randi()%100 + 50
	randomize()
	var y = randi()%100 + 50

	var posicao = Vector2(x, y)
#
	if num2 != 0:
		$Options/Option1/Label.text = str(int(num1) + randi()%10)
		$Options/Option2/Label.text = str(int(num1) + randi()%10)
		$Options/Option3/Label.text = str(int(num1) + randi()%10)
		$Options/Option4/Label.text = str(int(num1) / int(num2))
		display_text("Voce escolheu fugir usando a fuga das divisoes!")
		yield(self, "textbox_closed")
		display_text("Resolva essa divisao para atacar!")
		yield(self, "textbox_closed")
		display_text(gerar_operacoes("/"))
		display_text("%s / %d" % [int(num1), int(num2)])
		$Options.show()
		$seta.show()
		Global.fugir = true
		State.fugir = true
		emit_signal("fugiu")
	else:
		return num2 != 0
#	yield(get_tree().create_timer(0.25),"timeout")
#	$".".hide()


func _on_Attack_pressed():
	emit_signal("fugiu") == false
	Global.fugir = false
	State.fugir = false
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
	
#
	$Options/Option1/Label.text = str(int(num1) + randi()%50)
	$Options/Option2/Label.text = str(int(num1) + randi()%50)
	$Options/Option3/Label.text = str(int(num1) + randi()%50)
	$Options/Option4/Label.text = str(int(num1) + int(num2))
	display_text("Voce atacou usando o poder das adicoes!")
	yield(self, "textbox_closed")
	display_text("Resolva essa adicao para atacar!")
	yield(self, "textbox_closed")
	display_text(gerar_operacoes("+"))
	display_text("%s + %d" % [int(num1), int(num2)])
	$Options.show()
	$seta.show()
	$ActionsPanel.hide()



func _on_Defend_pressed():
	is_defending = true
	emit_signal("fugiu") == false
	Global.fugir = false
	State.fugir = false
	var rng = RandomNumberGenerator.new()
	randomize()
	var num1 = randi()%10
	randomize()
	var num2 = randi()%10
	
	$Options/Option1/Label.text = str(int(num1) + randi()%10)
	$Options/Option2/Label.text = str(int(num1) + randi()%10)
	$Options/Option3/Label.text = str(int(num1) + randi()%10)
	$Options/Option4/Label.text = str(int(num1) * int(num2))
	
	defendeu = true
	display_text("Resolva essa multiplicacao para se esquivar!")
	yield(self, "textbox_closed")
	display_text("%s x %d" % [int(num1), int(num2)])
	$Options.show()
	$seta.show()
	


func get_answer_from_string(string: String):
	
	var n1 = int(string.split(" ")[0])
	var n2 = int(string.split(" ")[2])
	var sinal = string.split(" ")[1]
	
	if sinal == "+":
		return int(n1) + int(n2)
	elif sinal == "-":
		return int(n1) - int(n2)
	elif sinal == "x":
		return int(n1) * int(n2)
	elif sinal == "/":
		return n1 / n2


func check():
	var option_text = int(get_node("Options/Option" + str(index + 1) + "/Label").text)
	var resposta = int(get_node("Options/Option4/Label").text)
	$seta.hide()
	$Options.hide()
	if int(option_text) == resposta:
		if Global.fugir == true and State.fugir == true:
			emit_signal("fugiu")
			display_text("Voce fugiu com sucesso!")
			yield(self, "textbox_closed")
			yield(get_tree().create_timer(0.25),"timeout")
			$".".hide()
			$"../MusicaBatalha".stop()
		elif defendeu == true:
			enemy_turn()
		else :
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
				emit_signal("fimbatalha8")
			enemy_turn()
	else:
		display_text("Infelizmente voce errou:(")
		yield(self, "textbox_closed")
		enemy_turn()

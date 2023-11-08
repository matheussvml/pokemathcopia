extends KinematicBody2D
class_name Player

signal dead

var velocity = Vector2()

export var speed = 120
var looking = "up"
var dead = false

func _ready():
	pass


func _process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("costa_walk")
		velocity.y = -speed
		looking = "up"
	if Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("idle_costa")
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("walk")
		velocity.y = speed
		looking = "down"
	if Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("idle")
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("lado_walk")
		$AnimatedSprite.flip_h = true
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("lado_walk")
		velocity.x = -speed
		$AnimatedSprite.flip_h = false
	
	

	if velocity == Vector2(0, 0):
		$AnimatedSprite.playing = false
#		$AnimatedSprite.play("idle_costa")

	velocity = move_and_slide(velocity)

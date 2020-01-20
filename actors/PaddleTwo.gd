extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var is_game_over

func _ready():
	is_game_over = get_node("../../Arena").game_over

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("player_two_up"):
		velocity.y -= 1
	if Input.is_action_pressed("player_two_down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	is_game_over = get_node("../../Arena").game_over
	if not is_game_over:
		get_input()
		move_and_slide(velocity)
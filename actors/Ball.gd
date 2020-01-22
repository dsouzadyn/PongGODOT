extends KinematicBody2D

var screen_size
var player_one_score = 0
var player_two_score = 0
var player_one_score_label
var player_two_score_label
var game_over_label
var direction = Vector2(-1.0, 1.0)
export (int) var ball_speed = 200
var is_game_over
var sound_player
func _ready():
	screen_size = get_viewport_rect().size
	player_one_score_label = $"../PlayerOneScore"
	player_two_score_label = $"../PlayerTwoScore"
	game_over_label = $"../GameOverLabel"
	is_game_over = get_node("../../Arena").game_over
	sound_player = get_node("../AudioStreamPlayer2D")

func _physics_process(delta):
	is_game_over = get_node("../../Arena").game_over
	if not is_game_over:
		var collision = move_and_collide(direction * ball_speed * delta)
		if collision:
			var collider = collision.get_collider()
			if collider.name == 'Paddle' or collider.name == 'PaddleTwo':
				direction.x = -direction.x
				sound_player.play()
			if collider.name == 'TopWall' or collider.name == 'BottomWall':
				direction.y = -direction.y
				sound_player.play()
			if collider.name == 'Paddle':
				player_one_score += 1
				player_one_score_label.text = str(player_one_score)
			if collider.name == 'PaddleTwo':
				player_two_score += 1
				player_two_score_label.text = str(player_two_score)
		if position.x < 0 or position.x > 800:
			get_node("../../Arena").game_over = true
			game_over_label.visible = not game_over_label.visible
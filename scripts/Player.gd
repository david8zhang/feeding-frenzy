extends Area2D

@export var speed = 480
enum SizeTypes {
	SMALL,
	MEDIUM,
	LARGE,
	XLARGE
}
var screen_size
var curr_score = 0
var curr_size = SizeTypes.SMALL

func start(pos):
	position = pos
	curr_score = 0
	$"../HUD".update_score(curr_score)
	show()
	$CollisionShape2D.disabled = false


func _ready():
	screen_size = get_viewport_rect().size
	hide()
	

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0


func _on_body_entered(body):
	eat_or_die(body)


func eat_or_die(enemy_fish):
	if (curr_size < enemy_fish.curr_mob_type.size):
		handle_player_die()
	else:
		handle_player_eat_fish(enemy_fish)


func handle_player_die():
	hide()
	$CollisionShape2D.disabled = true
	$"../".game_over()


func handle_player_win():
	if (curr_score >= 10000):
		hide()
		$CollisionShape2D.disabled = true
		$"../".win()
		

func handle_player_eat_fish(enemy_fish):
	curr_score += enemy_fish.curr_mob_type.value
	$EatSound.play()
	$"../HUD".update_score(curr_score)
	handle_player_scale_increase()
	handle_player_win()
	enemy_fish.queue_free()	


func handle_player_scale_increase():
	if (curr_score < 100):
		return
	if (curr_score >= 100 && curr_score < 1000):
		if (curr_size != SizeTypes.MEDIUM):
			$GrowSound.play()
			curr_size = SizeTypes.MEDIUM
			$Sprite2D.scale = Vector2(1.75, 1.75)
	elif (curr_score >= 1000 && curr_score < 5000):
		if (curr_size != SizeTypes.LARGE):
			$GrowSound.play()
			curr_size = SizeTypes.LARGE
			$Sprite2D.scale = Vector2(2.25, 2.25)
	elif (curr_score >= 5000 && curr_score < 10000):
		if (curr_size != SizeTypes.XLARGE):
			$GrowSound.play()
			curr_size = SizeTypes.XLARGE
			$Sprite2D.scale = Vector2(3.5, 3.5)
	

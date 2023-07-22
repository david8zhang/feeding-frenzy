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
	show()
	$CollisionShape2D.disabled = false

func _ready():
	screen_size = get_viewport_rect().size
	
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
		queue_free()
	else:
		curr_score += enemy_fish.curr_mob_type.value
		$"../HUD".update_score(curr_score)
		handle_player_scale_increase()
		enemy_fish.queue_free()	
	
func handle_player_scale_increase():
	if (curr_score <= 100):
		return
	if (curr_score > 100 && curr_score <= 1000):
		curr_size = SizeTypes.MEDIUM
		$Sprite2D.scale = Vector2(1.5, 1.5)
	elif (curr_score > 1000 && curr_score < 10000):
		curr_size = SizeTypes.LARGE
		$Sprite2D.scale = Vector2(2, 2)
	elif (curr_score > 10000 && curr_score <= 100000):
		curr_size = SizeTypes.XLARGE
		$Sprite2D.scale = Vector2(2.5, 2.5)
	

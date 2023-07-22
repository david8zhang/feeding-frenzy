extends Node

@export var enemy_scene: PackedScene
var screen_size

func _ready():
	screen_size = get_viewport().size
	$Player.start($PlayerSpawnPosition.position)
	$EnemySpawnTimer.start()

func _on_enemy_spawn_timer_timeout():
	var enemy_fish = enemy_scene.instantiate()
	var rand_y = randi_range(10, screen_size.y - 10)
	var spawn_x = 10
	var is_flipped = randi_range(0, 1) == 1
	if (is_flipped):
		spawn_x = screen_size.x - 10
	enemy_fish.spawn(is_flipped, Vector2(spawn_x, rand_y))
	add_child(enemy_fish)


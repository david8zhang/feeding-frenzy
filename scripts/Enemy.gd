extends RigidBody2D

enum SizeTypes {
	SMALL,
	MEDIUM,
	LARGE,
	XLARGE
}

const MOB_TYPES = [{
	"image": "res://sprites/mob1.png",
	"scale": 1,
	"value": 10,
	"size": SizeTypes.SMALL
}, {
	"image": "res://sprites/mob2.png",
	"scale": 1.5,
	"value": 50,
	"size": SizeTypes.MEDIUM
}, {
	"image": "res://sprites/mob3.png",
	"scale": 2,
	"value": 100,
	"size": SizeTypes.LARGE
}, {
	"image": "res://sprites/mob4.png",
	"scale": 2.5,
	"value": 200,
	"size": SizeTypes.XLARGE
}]
var rng = RandomNumberGenerator.new()
var curr_mob_type

func spawn(is_flipped, pos):
	var random_mob_type = MOB_TYPES[rng.randi_range(0, MOB_TYPES.size() - 1)]
	curr_mob_type = random_mob_type
	var image = Image.load_from_file(random_mob_type["image"])
	var texture = ImageTexture.create_from_image(image)
	var scale = random_mob_type["scale"]
	$Sprite2D.texture = texture
	position = pos
	if (is_flipped):
		$Sprite2D.scale = Vector2(-scale, scale)
		$CollisionShape2D.scale = Vector2(-scale, scale)
		linear_velocity = Vector2(randf_range(-200.0, -300.0), 0.0)
	else:
		$Sprite2D.scale = Vector2(scale, scale)
		$CollisionShape2D.scale = Vector2(scale, scale)
		linear_velocity = Vector2(randf_range(200.0, 300.0), 0.0)		

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

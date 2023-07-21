extends RigidBody2D

var mob_types = [{
	"image": "res://sprites/mob1.png",
	"scale": 1
}, {
	"image": "res://sprites/mob2.png",
	"scale": 1.5
}, {
	"image": "res://sprites/mob3.png",
	"scale": 2
}, {
	"image": "res://sprites/mob4.png",
	"scale": 2.5
}]
var rng = RandomNumberGenerator.new()

func _ready():
	# var random_mob_type = mob_types[rng.randi_range(0, mob_types.size() - 1)]
	var random_mob_type = mob_types[3]
	var image = Image.load_from_file(random_mob_type["image"])
	var texture = ImageTexture.create_from_image(image)
	var scale = random_mob_type["scale"]
	$Sprite2D.texture = texture
	$Sprite2D.scale = Vector2(scale, scale)
	position = Vector2(100, 100)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

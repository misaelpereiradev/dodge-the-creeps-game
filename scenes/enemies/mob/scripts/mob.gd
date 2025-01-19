extends Area2D

@onready var sprite: AnimatedSprite2D = $MobAnimatedSprite
@onready var shape: CollisionShape2D = $MobCollisionShape

const MIN_LINEAR_SPEED: int = 250
const MAX_LINEAR_SPEED: int = 450

var direction: Vector2 = Vector2.RIGHT
var linear_speed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_animation()
	set_random_speed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_mob(delta)

func set_random_animation() -> void:
	randomize()
	var animations: PackedStringArray = self.sprite.sprite_frames.get_animation_names()
	var random_index: int = randi_range(0, animations.size() - 1)
	self.sprite.play(animations[random_index])

func set_random_speed() -> void:
	randomize()
	self.linear_speed = randi_range(MIN_LINEAR_SPEED, MAX_LINEAR_SPEED)

func move_mob(delta: float) -> void:
	self.position += self.direction * self.linear_speed * delta

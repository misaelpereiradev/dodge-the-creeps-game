extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $MobAnimatedSprite
@onready var collision_shape: CollisionShape2D = $MobCollisionShape
@onready var visible_screen_notifier: VisibleOnScreenNotifier2D = $MobVisibleOnScreenNotifier

const MIN_LINEAR_SPEED: int = 250
const MAX_LINEAR_SPEED: int = 450

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
	var animations: PackedStringArray = self.animated_sprite.sprite_frames.get_animation_names()
	var random_index: int = randi_range(0, animations.size() - 1)
	self.animated_sprite.play(animations[random_index])

func set_random_speed() -> void:
	randomize()
	self.linear_speed = randi_range(MIN_LINEAR_SPEED, MAX_LINEAR_SPEED)

func move_mob(delta: float) -> void:
	self.position += Vector2.RIGHT.rotated(self.rotation) * self.linear_speed * delta


func _on_mob_visible_on_screen_notifier_screen_exited() -> void:
	self.queue_free()
	print("out of screen")

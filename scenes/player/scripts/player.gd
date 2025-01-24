extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $PlayerAnimatedSprite
@onready var collision_shape: CollisionShape2D = $PlayerCollisionShape

const LINEAR_SPEED: int = 400
const OFFSET_ROTATION: float = PI / 2

const WALK_ANIMATION: String = "WALK"
const UP_ANIMATION: String = "UP"

var min_position: Vector2;
var max_position: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_player_boundaries()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_player_movement(delta)

func set_player_boundaries() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	var shape_size: Vector2 = self.collision_shape.shape.get_rect().size
	self.min_position = Vector2.ZERO + shape_size / 2
	self.max_position = screen_size - shape_size / 2

func check_player_movement(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed(PlayerControls.RIGHT):
		direction += Vector2.RIGHT
	if Input.is_action_pressed(PlayerControls.DOWN):
		direction += Vector2.DOWN
	if Input.is_action_pressed(PlayerControls.LEFT):
		direction += Vector2.LEFT
	if Input.is_action_pressed(PlayerControls.UP):
		direction += Vector2.UP
		
	if direction == Vector2.ZERO:
		self.animated_sprite.pause()
		return
	
	if direction.y == 0:
		self.rotation = 0
		self.animated_sprite.flip_h = direction.angle() != 0
		self.animated_sprite.play(WALK_ANIMATION)
	else:
		self.animated_sprite.flip_h = false
		self.rotation = direction.angle() + OFFSET_ROTATION
		self.animated_sprite.play(UP_ANIMATION)
		
	self.position += direction.normalized() * LINEAR_SPEED * delta
	self.position = self.position.clamp(self.min_position, self.max_position)

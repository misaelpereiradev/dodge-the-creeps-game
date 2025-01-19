extends Area2D

@onready var sprite: AnimatedSprite2D = $PlayerAnimatedSprite
@onready var shape: CollisionShape2D = $PlayerCollisionShape

const LINEAR_SPEED: int = 400
const OFFSET_ROTATION: float = PI / 2

const WALK_ANIMATION: String = "WALK"
const UP_ANIMATION: String = "UP"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_player_movement(delta)

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
		self.sprite.pause()
		return
	
	if direction.y == 0:
		self.rotation = 0
		self.sprite.flip_h = direction.angle() != 0
		self.sprite.play(WALK_ANIMATION)
	else:
		self.sprite.flip_h = false
		self.rotation = direction.angle() + OFFSET_ROTATION
		self.sprite.play(UP_ANIMATION)
		
	self.position += direction.normalized() * LINEAR_SPEED * delta

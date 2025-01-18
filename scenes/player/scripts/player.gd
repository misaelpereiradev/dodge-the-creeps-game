extends Area2D

@onready var sprite: AnimatedSprite2D = $PlayerAnimatedSprite
@onready var shape: CollisionShape2D = $PlayerCollisionShape

const RIGHT: String = "ui_right"
const DOWN: String = "ui_down"
const LEFT: String = "ui_left"
const UP: String = "ui_up"

const LINEAR_SPEED: int = 400
const OFFSET_ROTATION: float = PI / 2

const WALK_ANIMATION: String = "walk"
const UP_ANIMATION: String = "up"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_player_movement(delta)

func check_player_movement(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed(RIGHT):
		direction += Vector2.RIGHT
	if Input.is_action_pressed(DOWN):
		direction += Vector2.DOWN
	if Input.is_action_pressed(LEFT):
		direction += Vector2.LEFT
	if Input.is_action_pressed(UP):
		direction += Vector2.UP
		
	if direction == Vector2.ZERO:
		self.sprite.pause()
		return
	
	var angle_degrees: int = round(rad_to_deg(direction.angle()))
	
	if angle_degrees == 180 or angle_degrees == 0:
		self.rotation = 0
		self.sprite.flip_h = direction.angle() != 0
		self.sprite.play(WALK_ANIMATION)
	else:
		self.rotation = direction.angle() + OFFSET_ROTATION
		self.sprite.play(UP_ANIMATION)
		
	self.position += direction.normalized() * LINEAR_SPEED * delta

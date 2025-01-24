extends Node

@export var enemy: PackedScene

@onready var path_follower: PathFollow2D = $MobSpawnerPath/MobSpawnerPathFollow
@onready var wait_timer: Timer = $MobSpawnerWaitTimer

const MIN_ROTATION: float = PI/4
const MAX_ROTATION: float = 3 * PI/4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mob_spawner_wait_timer_timeout() -> void:
	var random_position: Vector2 = self.get_random_position()
	var random_rotation: float = self.get_random_rotation()
	spawn_mob(random_position, random_rotation)
	
func get_random_position() -> Vector2:
	self.path_follower.progress_ratio = randf()
	return self.path_follower.position

func get_random_rotation() -> float:
	var rotation_variation = randf_range(MIN_ROTATION, MAX_ROTATION)
	return self.path_follower.rotation + rotation_variation

func spawn_mob(position: Vector2, rotation: float) -> void:
	var mob: Area2D = enemy.instantiate()
	mob.position = position
	mob.rotation = rotation
	self.add_child(mob)

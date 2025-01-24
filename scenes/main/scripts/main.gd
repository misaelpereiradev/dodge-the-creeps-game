class_name Main extends Node

@onready var world: World = $World
@onready var player: Player = $PlayerArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_area_hit() -> void:
	game_over()

func new_game():
	self.player.position = world.player_spawn.position

func game_over():
	self.world.wait_timer.stop()

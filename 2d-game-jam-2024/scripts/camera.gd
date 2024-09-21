extends Camera2D

@onready var player: RigidBody2D = $"../Player"
@onready var planet: Node2D = $"../Planet"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_dist = player.position.distance_to(planet.position)
	if player_dist != 0:
		zoom.x = 300 / (player_dist + 25)
		zoom.y = zoom.x

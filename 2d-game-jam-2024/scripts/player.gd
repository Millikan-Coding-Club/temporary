extends RigidBody2D

@onready var trajectory: Line2D = $Trajectory
@onready var timer: Timer = $Timer

@export var trajectory_interval = 0.1
@export var max_points = 300
@export var initial_thrust := 2000
@export var thrust := 10.0
var torque := .5

# found this in the rigidbody2d section 
# https://docs.godotengine.org/en/4.3/tutorials/physics/physics_introduction.html
func _ready():
	timer.wait_time = trajectory_interval
	timer.start()
	apply_force(Vector2(0, -initial_thrust))

func _integrate_forces(state):
	var rotation_direction = 0
	if Input.is_action_pressed("right"):
		apply_force(Vector2(thrust, 0))
		rotation_direction += 1
	if Input.is_action_pressed("left"):
		apply_force(Vector2(-thrust, 0))
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)
	update_ui()

#freezes the player when they crash, kinda buggy
func _on_hitbox_body_entered(body):
	if body.is_in_group("Planet"):
		game_over()


func game_over():
	set_deferred("freeze", true)
	$"../UI/crashed".show()
	$"../UI/leftstats".text = text % ["0", "0", "0", "0"]


var text = "Velocity: %s m9/s
	Angle: %s °
	Apoapsis: %s mi
	Periapsis:%s mi"
func update_ui():
	$"../UI/leftstats".text = text % [str(round(abs(linear_velocity.x) + abs(linear_velocity.y))), str(round(rad_to_deg(rotation))), "???", "???"]


func _on_timer_timeout() -> void:
	trajectory.add_point(position)
	print(trajectory.get_point_count())
	if trajectory.get_point_count() > max_points:
		trajectory.remove_point(0)

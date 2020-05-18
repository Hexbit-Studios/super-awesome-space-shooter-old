extends KinematicBody2D

export(int) var SPEED = 100
export(Vector2) var STARTING_DIRECTION = Vector2(1, 0)

var direction = Vector2()
var thrust = 0
var velocity = Vector2.ZERO

func _ready():
	direction = STARTING_DIRECTION

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	thrust = Input.get_action_strength("apply_thrust")
	
	if input_vector != Vector2.ZERO:
		direction = input_vector.normalized()
		rotation = atan2(direction.y, direction.x);

func _physics_process(delta):
	velocity = move_and_slide(direction * thrust * SPEED)

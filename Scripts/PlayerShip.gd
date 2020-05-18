extends KinematicBody2D

export(int) var SPEED = 100

var direction = Vector2.ZERO
var apply_thrust = false
var velocity = Vector2.ZERO

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		direction = input_vector.normalized()
		rotation = atan2(direction.y, direction.x);
	
	if Input.is_action_pressed("ui_accept"):
		apply_thrust = true
		
	if Input.is_action_just_released("ui_accept"):
		apply_thrust = false

func _physics_process(delta):
	if apply_thrust:
		velocity = move_and_slide(direction * SPEED)

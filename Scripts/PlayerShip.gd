extends KinematicBody2D

const Laser = preload("res://Scenes/Laser.tscn")

export(int) var SPEED = 75
export(Vector2) var STARTING_DIRECTION = Vector2(1, 0)

onready var primary_fire_point = $FirePointPrimary

var direction = Vector2()
var thrust = 0
var velocity = Vector2.ZERO

func _ready():
	direction = STARTING_DIRECTION

func _process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	thrust = Input.get_action_strength("apply_thrust")
	
	
	if Input.is_action_just_pressed("fire_primary"):
		fire_primary_weapon()
	
	if input_vector != Vector2.ZERO:
		direction = input_vector.normalized()
		rotation = atan2(direction.y, direction.x);

func _physics_process(_delta):
	velocity = move_and_slide(direction * thrust * SPEED)

func fire_primary_weapon():
	var laser = Laser.instance()
	var main = get_tree().current_scene
	main.add_child(laser)
	laser.global_position = primary_fire_point.global_position
	laser.global_rotation = global_rotation

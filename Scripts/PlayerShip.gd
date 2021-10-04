extends KinematicBody2D

const Laser = preload("res://Scenes/Laser.tscn")

export(int) var SPEED = 75
export(Vector2) var STARTING_DIRECTION = Vector2(1, 0)

onready var primary_fire_point = $FirePointPrimary

var direction = Vector2.ZERO
var unit_circle_direction = Vector2.ZERO
var velocity = Vector2.ZERO
var prev_unit_circle_direction

func _ready():
	direction = STARTING_DIRECTION

func _process(_delta):

	var horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var vertical = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = Vector2(horizontal, vertical).clamped(1)
	
	unit_circle_direction = Vector2.ZERO
	
	if abs(direction.x) > 0.7 || abs(direction.y) > 0.7:
		unit_circle_direction = direction
	elif abs(direction.x) <= 0.7 && abs(direction.y) <= 0.7:
		unit_circle_direction = Vector2.ZERO
	elif prev_unit_circle_direction != null:
		unit_circle_direction = prev_unit_circle_direction
	
	prev_unit_circle_direction = unit_circle_direction
	
	if unit_circle_direction != Vector2.ZERO:
		rotation = atan2(unit_circle_direction.y, unit_circle_direction.x)

func _physics_process(_delta):
	velocity = move_and_slide(unit_circle_direction * SPEED)

func fire_primary_weapon():
	var laser = Laser.instance()
	var main = get_tree().current_scene
	main.add_child(laser)
	laser.global_position = primary_fire_point.global_position
	laser.global_rotation = global_rotation

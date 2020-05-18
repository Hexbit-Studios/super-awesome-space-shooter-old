extends RigidBody2D

var thrust = Vector2(300, 0)

func _integrate_forces(_state):
	linear_velocity = thrust.rotated(rotation)

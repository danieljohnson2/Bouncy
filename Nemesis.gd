extends RigidBody2D

var change_size = 50
var until_change = 0

func _process(delta):
	until_change -= delta
	
	if until_change <= 0:
		until_change = rand_range(1, 3)
		var ball = get_parent()
		var offset = Vector2(rand_range(-change_size, change_size), rand_range(change_size, change_size))
		change_size *= 1.25
		self.linear_velocity += offset
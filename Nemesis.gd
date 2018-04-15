extends RigidBody2D

# Nemesis balls get random velocies added every now and then;
# each time the boost gets bigger.

var change_size = 50
var until_change = 0

func _process(delta):
	until_change -= delta
	
	if until_change <= 0:
		until_change = rand_range(1, 3)
		
		var offset = Vector2(rand_range(-1, 1), rand_range(-1,1)) * change_size
		self.linear_velocity += offset
		change_size *= 1.25
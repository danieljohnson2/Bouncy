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
		self.apply_impulse(Vector2(0,0), offset)
		change_size *= 1.25
		
	self.rotation = 0 # damping isn't always effective
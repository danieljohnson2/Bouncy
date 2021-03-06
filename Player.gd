extends RigidBody2D

export var acceleration = 200
export var stop_acceleration = 10
export var speed_factor = 3.0

export (NodePath) var die_player_path

# The movement controls represented as normalized vectors;
# these must be scaled before use by an acceleration factor
# and the time-delta.
var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }

# Provides a vector2 that indicates how the player should
# move; this vector is normalized, to avoid excess speed
# if the player hits two arrows at once. But if the shift
# key is help, we scale the result up.
func get_input_direction():
	var movement = Vector2(0,0)
	
	# Can't really use a dictionary lookup here since more than one
	# action can be engaged, so we just try each one.
	for action in directions.keys():
		if Input.is_action_pressed(action):
			movement += directions[action]
	
	movement = movement.normalized()
	if Input.is_action_pressed("ui_fast"): movement *= speed_factor
	return movement

# This return vector, but limits the size of it so
# that it won't reverse the sign of 'limit' if added
# to it. This prevents our stopping-impulse from
# ever overshooting a true stop, even if ramerates
# are awful.
func pin_by_sign(vector, limit):
	var x = min(abs(vector.x), abs(limit.x))
	var y = min(abs(vector.y), abs(limit.y))
	x *= sign(vector.x)
	y *= sign(vector.y)
	return Vector2(x,y)
	
func _process(delta):
	# Quit, Restart
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
		
	if not self.visible and Input.is_action_pressed("ui_restart"):
		get_tree().change_scene("res://Bouncy.tscn")
	
	# Stop is not instantaneous, but it slows you down fast
	if Input.is_action_pressed("ui_stop"):
		var stopage = -self.linear_velocity * stop_acceleration * delta
		var limited = pin_by_sign(stopage, self.linear_velocity)
		self.apply_impulse(Vector2(0,0), limited)
	
	var movement = get_input_direction()
	
	if movement != Vector2(0,0):
		self.apply_impulse(Vector2(), movement * acceleration * delta)
	
	self.rotation = 0 # damping isn't always effective

# Game over if we contact any 'nemesis'
func _on_Ball_body_entered(body):
	if body.is_in_group("nemesis"):
		# Dieing is not instant, we play an animation
		# that calls game_over when done.
		var die_player = get_node(die_player_path)
		if not die_player.is_playing():
			 die_player.play("Fade Out")

# Called from an animation when the player has finished dieing
func game_over():
	self.visible = false
	for go in get_tree().get_nodes_in_group("gameover"):
		go.visible = true

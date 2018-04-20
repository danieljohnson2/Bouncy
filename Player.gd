extends RigidBody2D

export var acceleration = 250
export var fast_acceleration = 750
export (NodePath) var die_player_path

# The movement controls represented as normalized vectors;
# these must be scaled before use by an acceleration factor
# and the time-delta.
var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }

func _process(delta):
	# Quit, Restart
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
		
	if not self.visible and Input.is_action_pressed("ui_restart"):
		get_tree().change_scene("res://Bouncy.tscn")
	
	# Stop isn't too subtle, but this works regardless of delta
	if Input.is_action_pressed("ui_stop"):
		self.linear_velocity = Vector2(0,0)
		
	# Can't really use a dictionary lookup here since more than one
	# action can be engaged, so we just try each one.
	# TODO: Combine the directions and normalize so mulit-keypress
	# doesn't get you more speed
	for action in directions.keys():
		if Input.is_action_pressed(action):
			var acc = fast_acceleration if Input.is_action_pressed("ui_fast") else acceleration
			self.apply_impulse(Vector2(), directions[action] * acc * delta)
	
	self.rotation = 0 # damping isn't always effective

# Game over if we contact any 'nemesis'
func _on_Ball_body_entered(body):
	if body.is_in_group("nemesis"):
		# Dieing is not instant, we play an animation
		# that calls game_over when done.
		var die_player = get_node(die_player_path)
		if not die_player.is_playing():
			 die_player.play("Fade Out")

func game_over():
	self.visible = false
	for go in get_tree().get_nodes_in_group("gameover"):
		go.visible = true

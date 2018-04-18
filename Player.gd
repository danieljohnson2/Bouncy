extends RigidBody2D

export var acceleration = 250
export var fast_acceleration = 750

var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }

func _process(delta):
	# Handle any user inputs here.
		
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
		
	if not self.visible and Input.is_action_pressed("ui_restart"):
		get_tree().change_scene("res://Bouncy.tscn")
	
	if Input.is_action_pressed("ui_stop"):
		self.linear_velocity /= 2
		
	for action in directions.keys():
		var acc = fast_acceleration if Input.is_action_pressed("ui_fast") else acceleration
		if Input.is_action_pressed(action):
			self.apply_impulse(Vector2(), directions[action] * acc * delta)

# Game over if we contact any 'nemisis'
func _on_Ball_body_entered(body):
	if body.is_in_group("nemesis"): die()

func die():
	self.visible = false
	for go in get_tree().get_nodes_in_group("gameover"):
		go.visible = true

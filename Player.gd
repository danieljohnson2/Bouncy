extends RigidBody2D

export var responsiveness = 250

var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
		
	for action in directions.keys():
		if Input.is_action_pressed(action):
			self.linear_velocity += directions[action] * responsiveness * delta

func die():
	self.visible = false
	for go in get_tree().get_nodes_in_group("gameover"):
		go.visible = true

func _on_Ball_body_entered(body):
	if body.is_in_group("nemesis"): die()

extends Node

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
	
	var ball = self.get_parent()
	
	for action in directions.keys():
		if Input.is_action_pressed(action):
			ball.speed += directions[action] * responsiveness * delta
			

func _on_Area_area_entered(area):
	var other = area.get_parent()
	if other.is_in_group("nemesis"):
		var ball = self.get_parent()
		ball.visible = false
		for go in get_tree().get_nodes_in_group("gameover"):
			go.visible = true
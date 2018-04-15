extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var speed = Vector2(50,50)
export var responsiveness = 100

var playfield

var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	playfield = get_tree().get_nodes_in_group("playfield")[0]

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	for action in directions.keys():
		if Input.is_action_pressed(action):
			self.speed += directions[action] * responsiveness * delta
	self.position += speed * delta
	
	var pos = self.position
	var size = self.texture.get_size()
	var pf_topleft = Vector2(0,0) + size / 2 # position is relative to playfield
	var pf_bottomright = pf_topleft + playfield.rect_size - size
	if pos.x < pf_topleft.x: speed.x = -speed.x
	if pos.y < pf_topleft.y: speed.y = -speed.y
	if pos.x > pf_bottomright.x: speed.x = -speed.x
	if pos.y > pf_bottomright.y: speed.y = -speed.y
extends Sprite

export var speed = Vector2(0,0)

var playfield

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	playfield = get_tree().get_nodes_in_group("playfield")[0]

func _process(delta):	
	var pos = self.position + speed * delta
	
	var size = self.texture.get_size()
	var pf_topleft = Vector2(0,0) + size / 2 # position is relative to playfield
	var pf_bottomright = pf_topleft + playfield.rect_size - size
	if pos.x < pf_topleft.x: speed.x = -speed.x
	if pos.y < pf_topleft.y: speed.y = -speed.y
	if pos.x > pf_bottomright.x: speed.x = -speed.x
	if pos.y > pf_bottomright.y: speed.y = -speed.y
	
	self.position = pos
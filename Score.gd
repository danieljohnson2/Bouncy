extends Label

var score = 0

func _ready():
	randomize() # somebody has to do it!

func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	
	if player.visible:
		score += delta
		self.text = "Score: %0.2f seconds" % score
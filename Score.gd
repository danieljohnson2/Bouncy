extends Label

var score = 0

func _ready():
	randomize() # somebody has to do it!

func _process(delta):
	# If the player is still alive, we update the score!
	var player = get_tree().get_nodes_in_group("player")[0]
	
	if player.visible:
		score += delta
		self.text = "Score: %0.2f seconds" % score
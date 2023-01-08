extends Node2D


@onready var playerScoreLabel = $"Player Score"
@onready var npcScoreLabel = $"NPC Score"
@onready var pongBall = $PongBall
@onready var npcPaddle = $"NPC-Paddle"
@onready var fuzzyness = $fuzzyness

var rng = RandomNumberGenerator.new()
var playerScore = 0
var npcScore = 0
var fuzzy = 0
var pongBallPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():	
	rng.randomize() # time based seed generator
	fuzzy = rng.randf_range(0,10) # start with a base fuzzyness
	playerScoreLabel.text = "Player Score: %d" % playerScore
	npcScoreLabel.text = "NPC Score: %d" % npcScore
	pongBall.connect("pongBallPositionChanged",_on_pongball_position_changed)



func _physics_process(delta):
	
	if fuzzy <= 5: # Only try to follow the ball if within the fuzzyness range
		return 
	
	if npcPaddle.position.y > pongBallPosition.y:
		npcPaddle.move_down()
	elif npcPaddle.position.y < pongBallPosition.y:
		npcPaddle.move_up()
	
	

func _on_pongball_position_changed(ballPosition):
	pongBallPosition = ballPosition

func _on_npc_goal_area_entered(area):
	if area.is_in_group("pongBall"): # Just in case you add extra elements in the game.
		playerScore = playerScore + 1
		playerScoreLabel.text = "Player Score: %d" % playerScore



func _on_player_goal_area_entered(area):
	if area.is_in_group("pongBall"):
		npcScore = npcScore + 1 
		npcScoreLabel.text = "NPC Score: %d" % npcScore


func _on_fuzzyness_timeout():
	fuzzy = rng.randf_range(0,10) # update fuzzyness
	fuzzyness.start()
	

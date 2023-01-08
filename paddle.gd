extends CharacterBody2D

const MOVE_VELOCITY = -400.0
@export var flipPaddle = false

@onready var paddleSprite = $paddleSprite

func _ready():
	if flipPaddle:
		paddleSprite.flip_h = true
		

func _input(event):
	if is_in_group("NPC"): # do not accept input as an npc 
		return 
	# Paddle up and down logic
	if Input.is_action_just_released("paddle_up"):
		move_up()
		
	elif Input.is_action_just_released("paddle_down"):
		move_down()

func _physics_process(delta):
	velocity.y *  delta
	move_and_slide()
	
func move_up():
	velocity.y = -MOVE_VELOCITY

func move_down():
	velocity.y = +MOVE_VELOCITY

# Now we can use this to just reverse the direction (Getting rid of clever code)
func _on_area_2d_area_entered(area):
	velocity.y = -velocity.y

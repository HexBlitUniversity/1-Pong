extends CharacterBody2D


@onready var pongBallSprite = $pongBallSprite

const BOUNCE_VELOCITY = -400.0

signal pongBallPositionChanged(position)

func _ready():
	velocity = Vector2(1,1).normalized() * BOUNCE_VELOCITY
	position = Vector2(0,0)
	

func _physics_process(delta):
	pongBallSprite.rotate(1)

	velocity * delta 
	move_and_slide()
	emit_signal("pongBallPositionChanged",global_position)
	print(global_position)

 

func _on_area_2d_area_entered(area):
	print(area.name)
	
	if area.is_in_group("npcGoal") or area.is_in_group("playerGoal"):
		position = Vector2(0,0) # Reset the position
		velocity = Vector2(1,1).normalized() * BOUNCE_VELOCITY
	elif area.is_in_group("yBoundary"):
		velocity.y = -velocity.y
	elif area.is_in_group("paddle"):
		#velocity = Vector2(1,1).normalized() * BOUNCE_VELOCITY
		velocity.x = -velocity.x
	pass # Replace with function body.

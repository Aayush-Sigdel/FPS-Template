class_name JumpPlayerState extends PlayerMovementState

@export var JUMP_VELOCITY = 7.5
@export var ACCELERATION = 0.05
@export var DECELERATION = 0.8
@export var SPEED = 12.0
@export var INPUT_MULTIPLAYER = 0.85

func enter(_pervious_state):
	PLAYER.velocity.y += JUMP_VELOCITY
	ANIMATION.play("jump_start")

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULTIPLAYER, ACCELERATION,DECELERATION)
	PLAYER.update_velocity()

	if Input.is_action_just_released("jump"):
		if PLAYER.velocity.y > 0:
			PLAYER.velocity.y = PLAYER.velocity.y / 4.0
	
	if PLAYER.is_on_floor():
		ANIMATION.play("jump_end")
		transition.emit("IdelPlayerState")

	if PLAYER.velocity.y < -2.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")
	
	if Input.is_action_just_pressed("shoot"):
		PLAYER.weapon._attack()

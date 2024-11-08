class_name FallingPlayerState extends PlayerMovementState

@export var ACCELERATION = 0.05
@export var DECELERATION = 0.8
@export var SPEED = 1.0

func enter(pervious_state):
	ANIMATION.pause()

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	if PLAYER.is_on_floor():
		ANIMATION.play("jump_end")
		transition.emit("IdelPlayerState")

	if Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchPlayerState")

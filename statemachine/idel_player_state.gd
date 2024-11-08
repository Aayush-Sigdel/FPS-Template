class_name IdelPlayerState extends PlayerMovementState

@export var ACCELERATION = 0.1
@export var DECELERATION = 0.5
@export var SPEED = 5

func enter(_pervious_state):
	if ANIMATION.is_playing() and ANIMATION.current_animation == "jump_end":
		await  ANIMATION.animation_finished
		ANIMATION.pause()
	else:
		ANIMATION.pause()
		
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchPlayerState")
	
	if PLAYER.velocity.length() > 0.0 and PLAYER.is_on_floor():
		transition.emit("WalkingPlayerState")

	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")

	if PLAYER.velocity.y < -2.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")

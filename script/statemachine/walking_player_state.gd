class_name WalkingPlayerState extends PlayerMovementState

@export var Top_Animation_Speed = 2.2
@export var ACCELERATION = 0.05
@export var DECELERATION = 0.5
@export var SPEED = 4.0

func  enter(_pervious_state):
	if ANIMATION.is_playing() and ANIMATION.current_animation == "jump_end":
		await  ANIMATION.animation_finished
		ANIMATION.play("walking",-1.0,1.0)
	else:
		ANIMATION.play("walking",-1.0,1.0)
	
func exit():
	ANIMATION.speed_scale = 1.0

func update(delta):

	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_pressed("sprint") and PLAYER.is_on_floor():
		transition.emit("SprintPlayerState")
		
	if Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchPlayerState")
		
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
		
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdelPlayerState")
		
	if PLAYER.velocity.y < -2.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")
  
func set_animation_speed(spd):
	var alpha = remap(spd,0.0,SPEED,0.0,1.0)
	ANIMATION.speed_scale = lerp(0.0, Top_Animation_Speed, alpha)
	

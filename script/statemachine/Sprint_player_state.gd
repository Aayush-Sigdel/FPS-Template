class_name SprintPlayerState extends PlayerMovementState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@export var Top_Animation_Speed = 1.0
@export var ACCELERATION = 0.2
@export var DECELERATION = 0.8
@export var SPEED = 8.0

func  enter(_pervious_state):
	if ANIMATION.is_playing() and ANIMATION.current_animation == "jump_end":
		await  ANIMATION.animation_finished
		animation_player.play("sprinting",-1.0,1.0)
	else:
		animation_player.play("sprinting",-1.0,1.0)
	
func exit():
	ANIMATION.speed_scale = 1.0

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_velocity()
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	
	set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_just_released("sprint") or PLAYER.velocity.length() == 0:
		transition.emit("IdelPlayerState")
			
	if Input.is_action_just_pressed("crouch") and PLAYER.velocity.length() > 6.0 and Input.is_action_pressed("up"):
		transition.emit("SlidingPlayerState")
		
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
		
	if PLAYER.velocity.y < -2.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")
		
func set_animation_speed(spd):
	var alpha = remap(spd,0.0,SPEED,0.0,1.0)
	animation_player.speed_scale = lerp(0.0, Top_Animation_Speed, alpha)
	

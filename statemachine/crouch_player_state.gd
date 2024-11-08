class_name CrouchPlayerState extends PlayerMovementState

@export var ACCELERATION = 0.2
@export var DECELERATION = 0.5
@export var SPEED = 2.0
@export_range(1, 6, 0.1) var SPEED_CROUCH = 4.0

@onready var crouch_shape_cast_3d: ShapeCast3D = $"../../ShapeCast3D"
var release = false

func enter(pervious_state):
	ANIMATION.speed_scale = 1.0
	if pervious_state.name != "SlidingPlayerState":
		ANIMATION.play("crouch", -1.0, SPEED_CROUCH)
	elif pervious_state.name == "SlidingPlayerState":
		ANIMATION.current_animation = "crouch"
		ANIMATION.seek(1.0,true)
		
func exit():
	release = false
	
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("crouch") == false and release == false:
		release = true
		uncrouch()
		
func uncrouch():
	if crouch_shape_cast_3d.is_colliding() == false and Input.is_action_just_pressed("crouch") == false:
		ANIMATION.play("crouch", -1.0, -SPEED_CROUCH*1.5, true)
		if ANIMATION.is_playing():
			await ANIMATION.animation_finished
		transition.emit("IdelPlayerState")
	elif crouch_shape_cast_3d.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()

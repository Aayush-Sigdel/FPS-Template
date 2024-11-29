class_name SlidingPlayerState extends PlayerMovementState

@export var ACCELERATION = 0.2
@export var DECELERATION = 0.5
@export var SPEED = 7.0
@export var TILT_AMOUNT = 0.09
@export_range(1, 6, 0.1) var SLIDE_ANIM_SPEED = 4.0
var num = [0.05,-0.05]

@onready var shape_cast_3d: ShapeCast3D = $"../../ShapeCast3D"

func enter(_pervious_state):
	set_tilt(PLAYER.current_rotation)
	ANIMATION.get_animation("sliding").track_set_key_value(4,0,PLAYER.velocity.length())
	ANIMATION.speed_scale = 1.0
	ANIMATION.play("sliding", -1.0, SLIDE_ANIM_SPEED)
	
func update(delta):
	PLAYER.update_gravity(delta)
	#PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	#PLAYER._update_camera(delta)
	#if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		#TILT_AMOUNT = 0.0
		#transition.emit("JumpPlayerState")

	if PLAYER.velocity.y < -2.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")
		
func set_tilt(player_rotation):
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT_AMOUNT * player_rotation, -0.1, 0.1)
	
	if tilt.z == 0.0:
		tilt.z = num.pick_random()
	ANIMATION.get_animation("sliding").track_set_key_value(7,1,tilt)
	ANIMATION.get_animation("sliding").track_set_key_value(7,2,tilt)
	
func finish():
	transition.emit("CrouchPlayerState")
	
func _physics_process(_delta: float) -> void:
	Global.debug.add_property("M", ANIMATION.get_animation("sliding").track_get_path(7), 2)

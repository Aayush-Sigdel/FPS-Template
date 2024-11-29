class_name Player  extends CharacterBody3D

@onready var crouch_shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var arm: Node3D = $arm
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_3d: Camera3D = $arm/Camera3D
@onready var weapon_camera: Camera3D = $arm/Camera3D/SubViewportContainer/SubViewport/weaponCamera

@onready var weapon: Node3D = $arm/Camera3D/SubViewportContainer/SubViewport/weaponCamera/Weapon

@onready var weapon_mesh: MeshInstance3D = $Weapon/Weapon_mesh


var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var mouse_rotaion : Vector3
var _player_rotation : Vector3
var _camera_rotaion : Vector3
var current_rotation : float

@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var mouse_sensitivity = 0.5


func _update_camera(delta):
	current_rotation = _rotation_input
	mouse_rotaion.x += _tilt_input * delta
	mouse_rotaion.x = clamp(mouse_rotaion.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotaion.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,mouse_rotaion.y,0.0)
	_camera_rotaion = Vector3(mouse_rotaion.x,0.0,0.0)
	
	arm.transform.basis = Basis.from_euler(_camera_rotaion)

	global_transform.basis = Basis.from_euler(_player_rotation)
	
	arm.rotation.z = 0.0
	_rotation_input = 0.0
	_tilt_input = 0.0 

func _ready() -> void:
	
	Global.Player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crouch_shape_cast_3d.add_exception($".")
	$arm/Camera3D/SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()
	
func _unhandled_input(event: InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * mouse_sensitivity
		_tilt_input = -event.relative.y * mouse_sensitivity
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		weapon.SwayWeapon(Vector2(event.relative.x,event.relative.y))
	
func _physics_process(delta: float) -> void:
	weapon_camera.global_transform = camera_3d.global_transform 
	Global.debug.add_property("MouseRotation", mouse_rotaion, 2)
	Global.debug.add_property("PlayerPosition",(position), 1)

	_update_camera(delta)

func update_gravity(delta):
	velocity += get_gravity() * delta
		
func update_input(SPEED : float, ACCELERATION : float, DECELERATION : float):
	Global.debug.add_property("MomentSpeed", SPEED, 2)
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.z = lerp(velocity.z, direction.z * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

func update_velocity():
	move_and_slide()

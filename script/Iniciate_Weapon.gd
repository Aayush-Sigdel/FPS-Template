@tool

extends Node3D


@export var Weapon_type : Weapons_resources:
	set(value):
		Weapon_type = value
		if Engine.is_editor_hint():
			load_Weapon()

@onready var weapon_mesh: MeshInstance3D = $Weapon_mesh
var MouseMovement : Vector2

func _ready() -> void:
	await owner.ready
	load_Weapon()

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_XBUTTON1) or Input.is_action_just_pressed("Weapon_up"):
		Weapon_type = load("res://materials/weapons/M4a1/m4a1.tres")
		load_Weapon()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_XBUTTON2) or Input.is_action_just_pressed("Weapon_down"):
		Weapon_type = load("res://materials/weapons/G15/g15.tres")
		load_Weapon()
	if event is InputEventMouseMotion:
		MouseMovement = event.relative
	Global.debug.add_property("MouseMovement", MouseMovement, 7)

func load_Weapon():
	weapon_mesh.mesh = Weapon_type.mesh
	position = Weapon_type.weapon_position
	rotation_degrees = Weapon_type.weapon_rotation
	
func SwayWeapon(delta):
	MouseMovement = MouseMovement.clamp(Weapon_type.Swaymin,Weapon_type.Swaymax)
	position.x = lerp(position.x, Weapon_type.weapon_position.x - (MouseMovement.x * Weapon_type.SwayAmountPosition) * delta, Weapon_type.SwaySpeedPosition)
	position.y = lerp(position.y, Weapon_type.weapon_position.y + (MouseMovement.y * Weapon_type.SwayAmountPosition) * delta, Weapon_type.SwaySpeedPosition)
	rotation_degrees.x = lerp(rotation_degrees.x, Weapon_type.weapon_rotation.x - (MouseMovement.x * Weapon_type.SwayAmountRotation)* delta, Weapon_type.SwaySpeedRotation)
	rotation_degrees.y = lerp(rotation_degrees.y, Weapon_type.weapon_rotation.y + (MouseMovement.y * Weapon_type.SwayAmountRotation)* delta, Weapon_type.SwaySpeedRotation)

func _physics_process(delta: float) -> void:
	SwayWeapon(delta)

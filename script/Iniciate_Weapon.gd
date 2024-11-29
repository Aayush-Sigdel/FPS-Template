@tool
extends Node3D

@onready var weapon_mesh: MeshInstance3D = $Weapon_mesh

@export var Weapon_type : Weapons_resources:
	set(value):
		Weapon_type = value
		if Engine.is_editor_hint():
			load_Weapon()


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

func load_Weapon():
	weapon_mesh.mesh = Weapon_type.mesh
	position = Weapon_type.weapon_position
	rotation_degrees = Weapon_type.weapon_rotation

func SwayWeapon(sway_amount):
	weapon_mesh.position.x += sway_amount.x * 0.0002 
	weapon_mesh.position.y += sway_amount.y * 0.0002
	
func _process(delta: float) -> void:
	weapon_mesh.position.x = lerp(weapon_mesh.position.x,0.0,delta*5)
	weapon_mesh.position.y = lerp(weapon_mesh.position.y,0.0,delta*5)

@tool
extends Node3D

signal weaponFired

@onready var weapon_mesh: MeshInstance3D = $Weapon_mesh

@onready var camera: Camera3D = $"../../../../.."




var raycast_test = preload("res://Assets/bullets.tscn")

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
	weapon_mesh.position.x += sway_amount.x * 0.0005 
	weapon_mesh.position.y += sway_amount.y * 0.0005
	
func _process(delta: float) -> void:
	weapon_mesh.position.x = lerp(weapon_mesh.position.x,0.0,delta*5)
	weapon_mesh.position.y = lerp(weapon_mesh.position.y,0.0,delta*5)

func _attack() -> void:
	
	weaponFired.emit()
	var space_state = camera.get_world_3d().direct_space_state
	var screen_center = get_viewport().size / 2
	var origin = camera.project_ray_origin(screen_center)
	var end = origin + camera.project_ray_normal(screen_center) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin,end)
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	print(result)
	if result:
		_bullet_decale(result.get("position"), result.get("normal"))

func _bullet_decale(position : Vector3, normal : Vector3) -> void:
	var instance = raycast_test.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = position
	instance.look_at(instance.global_transform.origin + normal, Vector3.UP)
	if normal != Vector3.UP and normal != Vector3.DOWN:
		instance.rotate_object_local(Vector3(1,0,0), 90)
	
	await get_tree().create_timer(3).timeout
	var fade = get_tree().create_tween()
	fade.tween_property(instance,"modulate:a",0,1.5)
	await get_tree().create_timer(1.5).timeout
	instance.queue_free()
	

@tool
extends Node3D

@onready var weapon: Node3D = $".."
@onready var light: OmniLight3D = $OmniLight3D
@onready var emmiter: GPUParticles3D = $GPUParticles3D
@onready var emmiter1: GPUParticles3D = $GPUParticles3D2

@export var flash_time : float = 0.05

func _ready() -> void:
	weapon.weaponFired.connect(add_muzzle_flash)


func add_muzzle_flash():
	light.visible = true
	emmiter.emitting = true
	emmiter1.emitting = true
	await get_tree().create_timer(flash_time).timeout
	light.visible = false
	

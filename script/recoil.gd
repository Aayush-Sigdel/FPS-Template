extends Node3D

@export var Recoil_Amount : Vector3
@export var Snap_Amount : float
@export var Speed : float

@onready var weapon: Node3D = $Weapon



var currentRotation : Vector3
var targetRotation : Vector3
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.weaponFired.connect(add_recoil)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	targetRotation = lerp(targetRotation, Vector3.ZERO, Speed * delta)
	currentRotation = lerp(currentRotation, targetRotation, Snap_Amount * delta)
	basis = Quaternion.from_euler(currentRotation)
	
func  add_recoil():
	targetRotation += Vector3(Recoil_Amount.x, randf_range(-Recoil_Amount.y, Recoil_Amount.y),randf_range(-Recoil_Amount.z, Recoil_Amount.z))

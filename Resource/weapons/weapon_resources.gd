class_name Weapons_resources extends Resource

@export_group("WeaponDetails") 
@export var Weapon_name : String
@export var Current_ammo: int
@export var Reserver_ammo : int
@export var Magazine : int
@export var Max_ammo : int
@export var Auto_fire : bool

@export_group("weapon Orintation") 
@export var mesh: Mesh
@export var weapon_position: Vector3
@export var weapon_rotation: Vector3

@export_group("WeaponSway")
@export var Swaymin : Vector2 = Vector2(-20.0,-20.0)
@export var Swaymax : Vector2 = Vector2(20.0,20.0)
@export_range(0.0,0.2,0.01) var SwaySpeedPosition : float = 0.07
@export_range(0.0,0.2,0.01) var SwaySpeedRotation : float = 0.1
@export_range(0.0,0.25,0.01) var SwayAmountPosition : float = 0.1
@export_range(0.0,50,0.01) var SwayAmountRotation : float = 30.0
#@export_group("Hand Orintation") 
#@export var Hand : PackedScene
#@export var hand_position: Vector3
#@export var hnad_rotation: Vector3

extends Camera3D

@onready var weapon_node: Node3D = $Weapon


func SwayWeapon(sway_amount):
	weapon_node.position.x += sway_amount.x * 0.0002 
	weapon_node.position.y += sway_amount.y * 0.0002
	
func _process(delta: float) -> void:
	weapon_node.position.x = lerp(weapon_node.position.x,0.0,delta*5)
	weapon_node.position.y = lerp(weapon_node.position.y,0.0,delta*5)

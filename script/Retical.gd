extends CenterContainer

@export var DOT_RADI = 1.0
@export var DOT_COLOUR = Color.WHITE
@export var RETICAL_LINE : Array[Line2D]
@export var Player_controler : CharacterBody3D
@export var RETILIC_SPEED : float = 0.25
@export var RETILIC_DISTANCE : float = 2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_adjust_retlic_line()
	
func _draw() -> void:
	draw_circle(Vector2(0,0), DOT_RADI , DOT_COLOUR)
func _adjust_retlic_line():
	var vel = Player_controler.get_real_velocity()
	var origin = Vector3(0,0,0)
	var Pos = Vector2(0,0)
	var Speed = origin.distance_to(vel)
	
	RETICAL_LINE[0].position = lerp(RETICAL_LINE[0].position, Pos + Vector2(0 , Speed * RETILIC_DISTANCE), RETILIC_SPEED)
	RETICAL_LINE[1].position = lerp(RETICAL_LINE[1].position, Pos + Vector2(0, -Speed * RETILIC_DISTANCE), RETILIC_SPEED)
	RETICAL_LINE[2].position = lerp(RETICAL_LINE[2].position, Pos + Vector2(Speed * RETILIC_DISTANCE, 0), RETILIC_SPEED)
	RETICAL_LINE[3].position = lerp(RETICAL_LINE[3].position, Pos + Vector2(-Speed * RETILIC_DISTANCE, 0 ), RETILIC_SPEED)

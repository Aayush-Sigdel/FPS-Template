extends PanelContainer

#var property
var framepersecond : String
@onready var property_container: VBoxContainer = %VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.debug = self
	visible = false
	
func _process(delta: float) -> void:
	if visible:
		framepersecond = "%.2f" % (1/ delta)
		Global.debug.add_property("FPS", framepersecond, 1)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible

func add_property(title : String, value , order):
	var target = property_container.find_child(title,true,false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name +": " + str(value)
	elif visible:
		target.text = target.name +": " + str(value)
		property_container.move_child(target,order)
	

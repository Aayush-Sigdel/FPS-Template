class_name StateMachine

extends Node

@export var CURRENT_STATE : State
var States : Dictionary = {} 

func _ready() -> void:
	for child in get_children():
		if child is State:
			States[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("state machine contains incompactable child node")
	
	await owner.ready
	CURRENT_STATE.enter(null)
	
func  _process(delta: float) -> void:
	CURRENT_STATE.update(delta)
	Global.debug.add_property("CurrentState", CURRENT_STATE.name, 4)
	
func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)
	
func on_child_transition(new_state_name : StringName) -> void:
	var new_state = States.get(new_state_name)
	if new_state != null:
		if new_state != CURRENT_STATE:
			CURRENT_STATE.exit()
			new_state.enter(CURRENT_STATE)
			CURRENT_STATE = new_state
	else:
		push_warning("state Does not exist")

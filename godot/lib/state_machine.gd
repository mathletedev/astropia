extends Node

@export var initial_state: State

var states := {}
var current_state: State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(_on_transition)


func _process(delta):
	if current_state:
		current_state.process(delta)


func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)


func _on_transition(from_state: State, to_state_name: String):
	if from_state != current_state:
		return

	var next_state = states.get(to_state_name.to_lower())
	if not next_state:
		return

	if current_state:
		current_state.exit()

	next_state.enter()

	current_state = next_state

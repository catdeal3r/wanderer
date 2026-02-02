extends Node3D

@onready var pause_menu: Control = $pause
@onready var settings_menu: Control = $Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.visible = false
	settings_menu.visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_menu.visible = not pause_menu.visible
		if pause_menu.visible:
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

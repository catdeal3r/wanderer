extends Control

@export var terrain: Terrain3D
@export var worldenv: WorldEnvironment
@export var reflecprobe: ReflectionProbe
@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	self.visible = false


func _on_lod_dropdown_item_selected(index: int) -> void:
	if index == 0:
		terrain.mesh_lods = 1
	elif index == 1:
		terrain.mesh_lods = 5
	elif index == 2:
		terrain.mesh_lods = 10


func _on_gi_dropdown_item_selected(index: int) -> void:
	if index == 0:
		worldenv.environment.sdfgi_enabled = false
		worldenv.environment.ssao_enabled = false
		# voxelgi.visible = false
		reflecprobe.visible = true
	elif index == 1:
		worldenv.environment.sdfgi_enabled = true
		worldenv.environment.ssao_enabled = true
		# voxelgi.visible = false
		reflecprobe.visible = false
	elif index == 2:
		worldenv.environment.sdfgi_enabled = true
		worldenv.environment.ssao_enabled = true
		# voxelgi.visible = true
		reflecprobe.visible = false

func _on_antialiasing_dropdown_item_selected(index: int) -> void:	
	if index == 0:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
	elif index == 1:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
	elif index == 2:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
	elif index == 3:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_8X)


func _on_vsync_dropdown_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif index == 1:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_renderdistance_dropdown_item_selected(index: int) -> void:
	if index == 0:
		camera.far = 10
	elif index == 1:
		camera.far = 40
	elif index == 2:
		camera.far = 2000
	elif index == 3:
		camera.far = 4000
	elif index == 4:
		camera.far = 8000


func _on_fsr_dropdown_item_selected(index: int) -> void:
	if index == 0:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 0.0)
	elif index == 1:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 0.25)
	elif index == 2:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 0.5)
	elif index == 3:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 0.75)
	elif index == 4:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 1.0)
	elif index == 5:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 1.25)
	elif index == 6:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 1.5)
	elif index == 7:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 1.75)
	elif index == 8:
		RenderingServer.viewport_set_fsr_sharpness(get_tree(), 2)

# camera.gd - Improved version with better debugging
extends Camera3D

@export var distance: float = 20.0
@export var height: float = 10.0
@export var rotation_speed: float = 1.0
@export var zoom_speed: float = 10.0
@export var scroll_zoom_speed: float = 2.0
@export var min_distance: float = 5.0
@export var max_distance: float = 25.0
@export var follow_smoothness: float = 5.0

signal left_click(position: Vector2)

@onready var player = get_parent()
var angle: float = 0.0
var current_position: Vector3

func _ready():
	current_position = global_position
	position_camera(true)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		angle -= rotation_speed * delta
	elif Input.is_action_pressed("ui_right"):
		angle += rotation_speed * delta

	if Input.is_action_pressed("ui_up"):
		distance = max(min_distance, distance - zoom_speed * delta)
	elif Input.is_action_pressed("ui_down"):
		distance = min(max_distance, distance + zoom_speed * delta)

	position_camera(false, delta)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance = max(min_distance, distance - scroll_zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance = min(max_distance, distance + scroll_zoom_speed)
		elif event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			left_click.emit(event.position)

func position_camera(force: bool = false, delta := 0.0):
	var offset = Vector3(
		cos(angle) * distance,
		height,
		sin(angle) * distance
	)
	var target_pos = player.global_position + offset

	if force:
		current_position = target_pos
	else:
		current_position = current_position.lerp(target_pos, delta * follow_smoothness)

	global_position = current_position
	look_at(player.global_position, Vector3.UP)


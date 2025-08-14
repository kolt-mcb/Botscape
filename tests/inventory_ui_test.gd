extends SceneTree

func _init():
	var scene = preload("res://terrain_generator.tscn").instantiate()
	get_root().add_child(scene)
	await process_frame
	var ui = scene.get_node("InventoryUI")
	assert(ui.panel.visible == false)
	var ev := InputEventAction.new()
	ev.action = "inventory"
	ev.pressed = true
	ui._input(ev)
	assert(ui.panel.visible == true)
	var camera = scene.get_node("Player/Camera3D")
	camera.make_current()
	var pickup = scene.get_node("WoodPickup")
	var screen_pos = camera.unproject_position(pickup.global_position)
	var ic = scene.get_node("InteractionController")
	ic.handle_mouse_click(screen_pos)
	await process_frame
	var inventory = scene.get_node("Inventory")
	assert(inventory.items.size() == 1)
	assert(!is_instance_valid(pickup))
	print("Inventory UI test passed")
	quit()

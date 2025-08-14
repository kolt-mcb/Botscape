extends SceneTree

const Inventory = preload("res://inventory.gd")

func _init():
        var inventory = Inventory.new()
        inventory.player_path = NodePath(".")
        get_root().add_child(inventory)
        await process_frame
        var ui = load("res://inventory_ui.tscn").instantiate()
        get_root().add_child(ui)
        await process_frame
        assert(ui.panel.visible == false)
        var ev := InputEventAction.new()
        ev.action = "inventory"
        ev.pressed = true
        Input.parse_input_event(ev)
        await process_frame
        assert(ui.panel.visible == true)
        print("Inventory UI test passed")
        quit()

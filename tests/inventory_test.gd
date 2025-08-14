extends SceneTree

const Inventory = preload("res://inventory.gd")

func _init():
    var inv = Inventory.new()
    inv.add_item("Generic Item", null, 2)
    inv.remove_item("Generic Item", 1)
    if inv.get_quantity("Generic Item") != 1:
        inv.free()
        push_error("Inventory remove_item failed")
        quit(1)
    inv.remove_item("Generic Item", 1)
    if inv.get_quantity("Generic Item") != 0:
        inv.free()
        push_error("Inventory remove_item to zero failed")
        quit(1)
    inv.free()
    print("Inventory add/remove item test passed")
    quit(0)

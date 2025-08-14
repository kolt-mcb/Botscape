extends SceneTree

const Inventory = preload("res://inventory.gd")

func _init():
    var inv = Inventory.new()
    var file = FileAccess.open("res://item_icon.svg", FileAccess.READ)
    inv.add_item("Generic Item", null)
    if file and inv.get_quantity("Generic Item") == 1:
        file.close()
        inv.free()
        print("Inventory add item test passed")
        quit(0)
    else:
        if file:
            file.close()
        inv.free()
        push_error("Inventory add item test failed")
        quit(1)

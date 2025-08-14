extends SceneTree

const InventoryScript = preload("res://inventory.gd")
const ItemDataScript = preload("res://item_data.gd")

func _init():
    var inv = InventoryScript.new()
    var data = ItemDataScript.new()
    data.name = "Generic Item"
    data.icon = Texture2D.new()
    inv.add_item(data, 2)
    inv.remove_item(data, 1)
    if inv.get_quantity(data) != 1:
        inv.free()
        push_error("Inventory remove_item failed")
        quit(1)
    inv.remove_item(data, 1)
    if inv.get_quantity(data) != 0:
        inv.free()
        push_error("Inventory remove_item to zero failed")
        quit(1)
    inv.free()
    print("Inventory add/remove item test passed")
    quit(0)

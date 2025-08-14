extends Node
class_name Inventory

var items: Dictionary = {}

func add_item(name: String, icon: Texture2D, quantity: int = 1) -> void:
    if items.has(name):
        items[name]["quantity"] += quantity
    else:
        items[name] = {
            "icon": icon,
            "quantity": quantity,
        }

func get_quantity(name: String) -> int:
    if items.has(name):
        return items[name]["quantity"]
    return 0

func get_items() -> Dictionary:
    return items.duplicate(true)

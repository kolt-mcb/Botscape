extends Node
class_name Inventory

const ItemData = preload("res://item_data.gd")

var items: Dictionary = {}  # key: ItemData, value: int quantity

func add_item(data: ItemData, quantity: int = 1) -> void:
    items[data] = items.get(data, 0) + quantity

func get_quantity(data: ItemData) -> int:
    return items.get(data, 0)

func get_items() -> Dictionary:
    return items.duplicate(true)

func remove_item(data: ItemData, quantity: int = 1) -> void:
    if not items.has(data):
        return
    items[data] -= quantity
    if items[data] <= 0:
        items.erase(data)

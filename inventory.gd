extends Node
class_name Inventory

signal inventory_changed

const ItemData = preload("res://item_data.gd")

@export var player_path: NodePath
@export var pickup_scene: PackedScene

var items: Array = []
@onready var player = get_node(player_path)

func _ready():
    add_to_group("Inventory")

func add_item(item: ItemData):
    items.append(item)
    inventory_changed.emit()

func remove_item(index: int):
    if index >= 0 and index < items.size():
        items.remove_at(index)
        inventory_changed.emit()

func drop_item(index: int, position: Vector3):
    if index < 0 or index >= items.size():
        return
    if pickup_scene == null:
        return
    var item: ItemData = items[index]
    var pickup = pickup_scene.instantiate()
    pickup.item = item
    pickup.global_position = position
    get_parent().add_child(pickup)
    remove_item(index)

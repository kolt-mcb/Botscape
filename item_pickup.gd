extends Area3D

const ItemData = preload("res://item_data.gd")

@export var item: ItemData
@onready var sprite: Sprite3D = $Sprite3D

func _ready():
	add_to_group("Pickup")
	if item and sprite:
		sprite.texture = item.icon

func pick_up():
	var inventory = get_tree().get_first_node_in_group("Inventory")
	if inventory:
		inventory.add_item(item)
	queue_free()

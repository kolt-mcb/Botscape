extends CanvasLayer
class_name InventoryPanel

@onready var list_container = $Panel/VBoxContainer

func _ready():
    hide()

func update_inventory(inv: Inventory) -> void:
    for child in list_container.get_children():
        child.queue_free()
    var items = inv.get_items()
    for name in items.keys():
        var data = items[name]
        var row = HBoxContainer.new()
        var icon = TextureRect.new()
        icon.texture = data["icon"]
        icon.custom_min_size = Vector2(32, 32)
        row.add_child(icon)
        var label = Label.new()
        label.text = "%s x%d" % [name, data["quantity"]]
        row.add_child(label)
        list_container.add_child(row)

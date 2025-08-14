extends CanvasLayer
class_name InventoryPanel

const ItemData = preload("res://item_data.gd")

@onready var list_container = $Panel/VBoxContainer
var menu: PopupMenu
var selected_item: ItemData

func _ready():
    hide()
    menu = PopupMenu.new()
    menu.add_item("Use", 0)
    menu.add_item("Drop", 1)
    add_child(menu)
    menu.id_pressed.connect(_on_menu_id_pressed)

func update_inventory(inv: Inventory) -> void:
    for child in list_container.get_children():
        child.queue_free()
    var items = inv.get_items()
    for data in items.keys():
        var quantity = items[data]
        var row = HBoxContainer.new()
        row.gui_input.connect(_on_row_input.bind(data))
        var icon = TextureRect.new()
        icon.texture = data.icon
        icon.custom_min_size = Vector2(32, 32)
        row.add_child(icon)
        var label = Label.new()
        label.text = "%s x%d" % [data.name, quantity]
        row.add_child(label)
        list_container.add_child(row)

func _on_row_input(event: InputEvent, data: ItemData) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        selected_item = data
        menu.position = event.global_position
        menu.popup()

func _on_menu_id_pressed(id: int) -> void:
    if selected_item == null:
        return
    var player = get_parent()
    if id == 0 and player.has_method("use_item"):
        player.use_item(selected_item)
    elif id == 1 and player.has_method("drop_item"):
        player.drop_item(selected_item)
    selected_item = null

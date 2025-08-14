extends CanvasLayer
class_name InventoryPanel

@onready var list_container = $Panel/VBoxContainer
var menu: PopupMenu
var selected_item: String = ""

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
    for name in items.keys():
        var data = items[name]
        var row = HBoxContainer.new()
        row.gui_input.connect(_on_row_input.bind(name))
        var icon = TextureRect.new()
        icon.texture = data["icon"]
        icon.custom_min_size = Vector2(32, 32)
        row.add_child(icon)
        var label = Label.new()
        label.text = "%s x%d" % [name, data["quantity"]]
        row.add_child(label)
        list_container.add_child(row)

func _on_row_input(event: InputEvent, name: String) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        selected_item = name
        menu.position = event.global_position
        menu.popup()

func _on_menu_id_pressed(id: int) -> void:
    if selected_item == "":
        return
    var player = get_parent()
    if id == 0 and player.has_method("use_item"):
        player.use_item(selected_item)
    elif id == 1 and player.has_method("drop_item"):
        player.drop_item(selected_item)
    selected_item = ""

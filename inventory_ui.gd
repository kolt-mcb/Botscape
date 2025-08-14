extends CanvasLayer

@export var slot_count: int = 16

@onready var panel: Panel = $Panel
@onready var grid: GridContainer = $Panel/Grid
@onready var inventory: Inventory = get_tree().get_first_node_in_group("Inventory")

var slots: Array = []

func _ready():
    panel.visible = false
    setup_slots()
    if inventory:
        inventory.inventory_changed.connect(update_slots)
    update_slots()

func setup_slots():
    for i in range(slot_count):
        var btn := TextureButton.new()
        btn.expand = true
        btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
        btn.connect("gui_input", Callable(self, "_on_slot_gui_input").bind(i))
        grid.add_child(btn)
        slots.append(btn)

func _process(_delta):
    if Input.is_action_just_pressed("inventory"):
        panel.visible = not panel.visible

func update_slots():
    for i in range(slot_count):
        var btn: TextureButton = slots[i]
        if inventory and i < inventory.items.size():
            btn.texture_normal = inventory.items[i].icon
        else:
            btn.texture_normal = null

func _on_slot_gui_input(event: InputEvent, index: int):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        var popup := PopupMenu.new()
        add_child(popup)
        popup.add_item("Use", 0)
        popup.add_item("Drop", 1)
        popup.connect("id_pressed", Callable(self, "_on_popup_id_pressed").bind(index, popup))
        popup.position = get_viewport().get_mouse_position()
        popup.popup()

func _on_popup_id_pressed(id: int, index: int, popup: PopupMenu):
    popup.queue_free()
    if not inventory:
        return
    if id == 0:
        inventory.remove_item(index)
    elif id == 1:
        if inventory.player:
            inventory.drop_item(index, inventory.player.global_position)

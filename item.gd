extends Area3D

@export var item_name: String = "Generic Item"
@export var icon: Texture2D = preload("res://item_icon.svg")
@export var quantity: int = 1

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body.has_method("pick_up_item"):
        body.pick_up_item(self)
        queue_free()

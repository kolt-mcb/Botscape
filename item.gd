extends Area3D

@export var data: ItemData
@export var quantity: int = 1

func _ready() -> void:
    if data:
        $Sprite3D.texture = data.icon
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body.has_method("pick_up_item"):
        body.pick_up_item(self)
        queue_free()

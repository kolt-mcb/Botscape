extends Area3D

@export var data: ItemData
@export var quantity: int = 1

func _ready() -> void:
    if data:
        $Sprite3D.texture = data.icon

func pick_up(player: Node) -> void:
    if player.has_method("pick_up_item"):
        player.pick_up_item(self)
        queue_free()

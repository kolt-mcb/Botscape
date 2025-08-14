extends SceneTree

func _init():
    const ItemData = preload("res://item_data.gd")
    var paths = [
        "res://icon.svg",
        "res://items/wood.tres",
        "res://item_pickup.tscn",
    ]
    for p in paths:
        var f = FileAccess.open(p, FileAccess.READ)
        if f == null:
            push_error("Failed to open %s" % p)
            quit(1)
        f.close()

    var item = load("res://items/wood.tres")
    if item == null or not (item is ItemData):
        push_error("ItemData resource failed to load")
        quit(1)

    print("Resources opened successfully")
    quit(0)

extends SceneTree

func _init():
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
    print("Resources opened successfully")
    quit(0)

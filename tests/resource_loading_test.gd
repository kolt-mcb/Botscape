extends SceneTree

func _init():
    var file = FileAccess.open("res://icon.svg", FileAccess.READ)
    if file == null:
        push_error("Failed to open icon")
        quit(1)
    else:
        file.close()
        print("Resource opened successfully")
        quit(0)

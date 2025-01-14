extends Node2D
class_name CardManager




func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            raycast_card_check()
            print_tree()
        else:
            print("rel clik")


func raycast_card_check():
    var space_state = get_world_2d().direct_space_state
    var parameters = PhysicsPointQueryParameters2D.new()
    parameters.position = get_global_mouse_position()
    parameters.collide_with_areas = true
    parameters.collision_mask = 1
    var result = space_state.intersect_point(parameters)
    if result.size() > 0 :
        print(result[0].collider.get_parent())
    else:
        return null
    

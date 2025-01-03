class_name Hand
extends ColorRect




var live_hand : Array[PackedScene] = []
var card_size = GlobalData.card_size
const max_hand_size = 5
var hand_size = 0


@export var hand_curve: Curve
@export var rotation_curve: Curve
@export var max_rotation_degrees := 10
@export var x_sep := 50
@export var y_min := 50
@export var y_max := -50


@onready var stab_card = preload("res://src/scenes/card_scenes/cards/dmg_cards/stab.tscn")
@onready var heal_card = preload("res://src/scenes/card_scenes/cards/buff_debuff_cards/heal.tscn")
@onready var guard_card = preload("res://src/scenes/card_scenes/cards/def_cards/guard.tscn")
var card_inventory = []

func _ready() -> void:
    card_inventory.append(stab_card)
    card_inventory.append(heal_card)
    card_inventory.append(guard_card)


func draw() -> void:
    var index = randi_range(0,2)
    if hand_size < max_hand_size:
        var cards = card_inventory[index]
        var card = cards.instantiate()
        live_hand.append(cards)
        var child_array = []
        child_array.append(cards)
        add_child(card)
        hand_size += 1
        print("Live Hand : ",live_hand)
        print("CHILDS : ", card.name)
    _update_cards()


func discard() -> void:
    
    # Verifica si el nodo está en el árbol de nodos
    if not card_node or not is_instance_valid(card_node):
        return

    # Elimina la carta de la lista de cartas en la mano
    for i in range(live_hand.size()):
        if live_hand[i].name == card_node.name:
            live_hand.remove_at(i)
            break
    
    # Libera el nodo de la escena
    card_node.queue_free()
    hand_size -= 1

    # Actualiza las posiciones de las cartas
    _update_cards()



func _update_cards() -> void:
    var cards := get_child_count()
    var all_cards_size := Card.SIZE.x * cards + x_sep * (cards - 1)
    var final_x_sep = x_sep
    
    if all_cards_size > size.x:
        final_x_sep = (size.x - Card.SIZE.x * cards) / (cards - 1)
        all_cards_size = size.x

    var offset := (size.x - all_cards_size) / 2
    
    for i in cards:
        var card := get_child(i)
        var y_multiplier := hand_curve.sample(1.0 / (cards-1) * i)
        var rot_multiplier := rotation_curve.sample(1.0 / (cards-1) * i)
        
        if cards == 1:
            y_multiplier = 0.0
            rot_multiplier = 0.0
        
        var final_x: float = offset + Card.SIZE.x * i + final_x_sep * i
        var final_y: float = y_min + y_max * y_multiplier
        
        card.position = Vector2(final_x, final_y)
        card.rotation_degrees = max_rotation_degrees * rot_multiplier

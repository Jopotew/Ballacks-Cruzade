## DeckDisplay.gd
class_name HandDisplay
extends ColorRect

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


@export var hand_curve: Curve
@export var rotation_curve: Curve
@export var max_rotation_degrees := 10
@export var x_sep := 20
@export var y_min := 0
@export var y_max := -50

var card_size = GlobalData.card_size
var hand_size = 0

var card_inventory : Array   # El inventario completo de cartas. Solo los nombres. 
var deck_repository : Array[Dictionary] #Diccionario de card data separado para usar. . 
var card_data : Dictionary #Informacion de las cartas
var live_hand : Array[String] #Mano activa del jugador

const MAX_HAND_SIZE = 5
const CARD_MODEL = preload("res://src/scenes/card_scenes/card_model.tscn")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



func _ready() -> void:
    CombatService.connect("combat_started",_on_combat_started)
    

func load_card_res(player_deck : Array[String]) -> Dictionary:
    var card_resources := {}
    
    for card_name in player_deck:
        var card_folder := "res://src/resources/card_res/" + card_name + "/"
        var card_data := {}
        
        card_data.text = load(card_folder + "card_text.tres")
        card_data.action = load(card_folder + "card_action.tres")
        card_resources[card_name] = card_data

    return card_resources


func _on_combat_started():
    print("COMBAT STARTED")

func draw() -> void:
    if hand_size >= MAX_HAND_SIZE:
        print("No se pueden robar más cartas. La mano está llena.")
        return

    var index = randi_range(0, card_inventory.size() - 1)
    var card_data = card_inventory[index]

    var card_instance = card_data.instantiate()

    # Verificar si la instancia es válida
    if not card_instance is Card:
        print("ERROR: Carta no es del tipo esperado.")
        return

    live_hand.append({
        "scene": card_data,
        "node": card_instance
    })
    add_child(card_instance)
    hand_size += 1

    update_cards()




#func discard(card_to_remove : Node2D) -> void:
    #if not card_to_remove or not is_instance_valid(card_to_remove):
        #return
        #
    #for i in range(live_hand.size()):
        #if live_hand[i].name == card_to_remove.name:
            #live_hand.remove_at(i)
            #break
            #
    #card_to_remove.queue_free()
    #hand_size -= 1
    #update_cards()


func update_cards() -> void:
    var cards := get_child_count()
    var all_cards_size: int = card_size.x * cards + x_sep * (cards - 1)
    var final_x_sep = x_sep

    # Ajustar separación si las cartas exceden el ancho disponible
    if all_cards_size > size.x:
        final_x_sep = (size.x - card_size.x * cards) / (cards - 1)
        all_cards_size = size.x

    var offset := (size.x - all_cards_size) / 2

    # Posicionar cada carta
    for i in range(cards):
        var card = get_child(i)

        # Verificar si el hijo es una carta válida
        if not card is Card:
            print("WARNING: Nodo hijo no es de tipo 'Card'. Nodo:", card)
            continue

        var y_multiplier := hand_curve.sample(1.0 / (cards - 1) * i)
        var rot_multiplier := rotation_curve.sample(1.0 / (cards - 1) * i)

        if cards == 1:
            y_multiplier = 0.0
            rot_multiplier = 0.0

        var final_x: float = offset + card_size.x * i + final_x_sep * i
        var final_y: float = y_min + y_max * y_multiplier

        card.position = Vector2(final_x, final_y)
        card.rotation_degrees = max_rotation_degrees * rot_multiplier


func initialize_inventory(inventory: Array[String]) -> void:
    card_data = load_card_res(inventory)
    deck_repository = set_card_data(card_data)
    set_card_inventory()
    set_hand()
    
func set_card_inventory():
    var index = randi_range(0, deck_repository.size() - 1)
    for card in deck_repository:
        card_inventory.append(card["card_name"])
  
func set_card_data(card_data : Dictionary):
    for card_name in card_data:
        var data = card_data[card_name]
        deck_repository.append({
            "card_name": data.text.name,
            "scene": CARD_MODEL,  
            "action": data.action,
            "text": data.text
        })
    return deck_repository


func set_hand():
    while hand_size < MAX_HAND_SIZE:
        # Seleccionar un índice al azar del mazo
        var index = randi_range(0, deck_repository.size() - 1)
        var card_data = deck_repository[index]
        var card_scene = card_data["scene"]
        var card_name = card_data["card_name"]

        # Instanciar la carta desde la escena
        var card_instance = card_scene.instantiate()

        # Verificar el tipo de la instancia
        print("")
        print("Instancia creada:", card_instance, "Tipo:", typeof(card_instance))

        if not card_instance is Card:
            print("ERROR: La instancia no es del tipo 'Card'. Tipo real:", typeof(card_instance))
            continue

        # Configurar la carta
        card_instance.set_res(card_data["action"], card_data["text"])

        # Añadir la carta a la mano y al árbol de nodos
        live_hand.append(card_name)
        add_child(card_instance)
        hand_size += 1

    update_cards()

 


func add_card_to_hand(new_card_data: Dictionary) -> void:
    if hand_size >= MAX_HAND_SIZE:
        print("No se pueden añadir más cartas. La mano está llena.")
        return

    var card_scene = new_card_data["scene"]
    var card_instance = card_scene.instantiate()

    # Verificar si la instancia es del tipo esperado
    if not card_instance is Card:
        print("ERROR: La carta añadida no es de tipo 'Card'. Tipo:", typeof(card_instance))
        return

    # Configurar los datos de la carta
    card_instance.set_res(new_card_data["action"], new_card_data["text"])
    live_hand.append(new_card_data["card_name"])

    # Añadir la carta al nodo
    add_child(card_instance)
    hand_size += 1

    # Actualizar posiciones
    update_cards()


func _on_combat_manager_turn_ended() -> void:
    if hand_size < MAX_HAND_SIZE and deck_repository.size() > 0:
        var index = randi_range(0, deck_repository.size() - 1)
        var next_card_data = deck_repository[index]
        add_card_to_hand(next_card_data)

extends Control
class_name CardModel

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
@export var card_action_data : Resource 
@export var card_text_data : Resource


@onready var description_label: Label = $DescriptionLabel
@onready var cost_label: Label = $CostLabel
@onready var dmg_label: Label = $DmgLabel
@onready var card_name_label: Label = $CardNameLabel
@onready var card_sprite: TextureRect = $CardSprite
@onready var card_type : Label = $TypeLabel


var card_damage : int
var card_healing : int
var card_effects : Array[EffectRes]
var card_element : String

var is_being_dragged : bool = false
var drag_offset := Vector2()


const CARD_SIZE := Vector2(150, 230)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


func _ready() -> void:
    GlobalData.card_size = CARD_SIZE
    set_card_action()
    set_card_model()
    visible = true
    
func _process(delta: float) -> void:
    if is_being_dragged:
        var mouse_position = get_viewport().get_mouse_position()
        global_position = mouse_position + drag_offset
    
    
func set_res(_action : Resource, _text: Resource):
    card_action_data = _action
    card_text_data = _text
    

    
func  set_card_model():
    cost_label.set_text(str(card_text_data.cost))
    card_name_label.set_text(card_text_data.name)
    description_label.set_text(card_text_data.description)
    card_sprite.set_texture(card_text_data.sprite)
    card_type.set_text(card_text_data.type)
    
    
func set_card_action():
    card_damage = card_action_data.damage 
    card_healing = card_action_data.healing
    card_effects = card_action_data.effects
    card_element = card_action_data.element
    
    
    
func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == 1:
        if event.pressed:
            # Iniciar el arrastre si el clic es válido
            is_being_dragged = true
            drag_offset = global_position - event.global_position
        else:
            # Terminar el arrastre cuando se suelta el botón
            if is_being_dragged:
                emit_signal("card_dropped", self)  # Señal personalizada si es necesario
            is_being_dragged = false
                
func _get_drag_data(position: Vector2) -> Variant:
    return {"action": card_action_data, "text": card_text_data}

# Lógica para moverse mientras se arrastra (te permite mover el nodo)
func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and is_being_dragged:
        # Si estamos arrastrando, mueve el nodo con el ratón
        self.position += event.relative

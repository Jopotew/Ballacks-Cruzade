extends Resource
class_name CardRes

## Tipo de carta: "daño", "defensivo", "buff", "debuff", etc.
@export var type: String

## Nombre de la carta. Ejemplo: "Stab", "Heal", etc.
@export var name: String

## Descripción detallada de lo que hace la carta.
@export var description: String

## Daño que hace la carta (solo se usa si es una carta de daño).
@export var damage: int = 0

## Curación que proporciona la carta (solo se usa si es una carta de curación).
@export var healing: int = 0

## Costo de la carta en puntos de energía.
@export var cost: int

## Elemento de la carta, como "fuego", "agua", "tierra", etc.
@export var element: String

## Lista de efectos aplicados por la carta, es un Resource de Effectos. Son "buffs", "debuffs", "status effects".
@export var effects: Array[EffectRes] = []

func get_damage():
    return damage



#Se crean todas las cartas en base a esto. Tipo las clases del pj.en archivos distintos. 

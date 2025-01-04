extends Resource
class_name CardAction


## Daño que hace la carta (solo se usa si es una carta de daño).
@export var damage: int = 0

## Curación que proporciona la carta (solo se usa si es una carta de curación).
@export var healing: int = 0

## Elemento de la carta, como "fuego", "agua", "tierra", etc.
@export var element: String

## Lista de efectos aplicados por la carta, es un Resource de Effectos. Son "buffs", "debuffs", "status effects".
@export var effects: Array[EffectRes] = []

extends Node

enum ActionType {
	MELEE,
	RANGED,
	SPECIAL
}

enum ActionTarget {
	ENEMY_SINGLE,
	ALLY_SINGLE,
	ENEMY_MULTIPLE,
	ALLY_MULTIPLE,
	SELF
}

enum EffectType {
	NONE,
	STATUS,
	HEAL,
	CLEAR_STATUS,
	BUFF
}

enum StatusType {
	NONE,
	BLEED,
	POISON,
	BURN,
	STUN
}

enum BuffType {
	NONE,
	BUFF,
	MALUS
}

enum BuffAmountType {
	NONE,
	PERCENTAGE,
	FLAT
}

enum StatType {
	NONE,
	ATTACK,
	PROTECTION,
	SPEED
}
function items_register_all()
{
	// item_define(id, название, описание, тип, функция использования)
	// тип: "item" (обычный), "equip" (экипировка), "key" (ключевой)
	item_define("potion", "Potion", "A small bottle. Restores 10 HP.", "item", item_use_potion);
	item_define_gear("wood_sword", "Wooden Sword", "A training sword. ATK +2.", "weapon", 2, 0);
	item_define_gear("leather_vest", "Leather Vest", "Light armor. DEF +2.", "armor", 0, 2);
	item_define("old_key", "Old Key", "Opens something somewhere.", "key", undefined);
}

// Что возвращать из функции использования:
//   ITEM_USED - предмет использован и тратится (так же, если ничего не вернуть)
//   ITEM_FAIL - ничего не произошло, предмет остаётся, выбор персонажа не закрывается
//   ITEM_KEEP - использован, но не тратится (например, экипировка)
// _m это структура персонажа из отряда: _m.name, _m.hp, _m.hp_max, _m.atk, _m.def

function item_use_potion(_m)
{
	if(_m.hp >= _m.hp_max)
	{
		create_text_simple(_m.name + " is already at full HP.");
		return ITEM_FAIL;
	}
	party_add_stat(_m.name, "hp", 10);
	create_text_simple(_m.name + " healed 10 HP.");
	return ITEM_USED;
}

function item_use_wood_sword(_m)
{
	create_text_simple(_m.name + " tries the Wooden Sword.");
	return ITEM_KEEP;
}
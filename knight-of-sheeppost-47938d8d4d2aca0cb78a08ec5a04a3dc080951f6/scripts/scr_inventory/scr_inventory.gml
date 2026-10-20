#macro ITEM_FAIL 0
#macro ITEM_USED 1
#macro ITEM_KEEP 2
// max copies of one item in one slot
#macro INV_STACK_MAX 1
// slots in the Items tab
#macro INV_MAX_ITEMS 8
// slots in the Equip tab
#macro INV_MAX_EQUIP 16
// -1 = unlimited (key items)
#macro INV_MAX_KEY -1

function inv_init()
{
	if(variable_global_exists("inv")) { return; }
	global.inv = [];
	global.items = {};
	items_register_all();
}


///@param id
///@param name
///@param description
///@param type  "item", "equip" or "key"
///@param use_function
function item_define(_id, _name, _desc, _type, _use)
{
	global.items[$ _id] = {
		item_id : _id,
		name : _name,
		desc : _desc,
		type : _type,
		use : _use,
		slot : "",
		atk : 0,
		def : 0
	};
}

///@param id
///@param name
///@param description
///@param slot  "weapon" or "armor"
///@param atk_bonus
///@param def_bonus
function item_define_gear(_id, _name, _desc, _slot, _atk, _def)
{
	item_define(_id, _name, _desc, "equip", item_use_equip);
	var _d = global.items[$ _id];
	_d.slot = _slot;
	_d.atk = _atk;
	_d.def = _def;
}
///@param id
function item_get(_id)
{
	inv_init();
	if(variable_struct_exists(global.items, _id)) { return global.items[$ _id]; }
	return undefined;
}

///@param id
///@param use_function
function item_set_use(_id, _fn)
{
	var _def = item_get(_id);
	if(_def != undefined) { _def.use = _fn; }
}

///@param type
function inv_capacity(_type)
{
	switch(_type)
	{
		case "item": return INV_MAX_ITEMS;
		case "equip": return INV_MAX_EQUIP;
	}
	return INV_MAX_KEY;
}

///@param type
function inv_is_full(_type)
{
	var _cap = inv_capacity(_type);
	return (_cap >= 0 && array_length(inv_get_list(_type)) >= _cap);
}

///@param id
///@param [count]
///@param [notify]
function inv_add(_id, _count = 1, _notify = true)
{
	inv_init();
	var _def = item_get(_id);
	if(_def == undefined)
	{
		show_debug_message("inv_add: unknown item " + string(_id));
		return 0;
	}

	var _added = 0;
	repeat(_count)
	{
		var _done = false;

		for(var i = 0; i < array_length(global.inv); i++)
		{
			if(global.inv[i].item_id == _id && global.inv[i].count < INV_STACK_MAX)
			{
				global.inv[i].count++;
				_done = true;
				break;
			}
		}

		if(!_done)
		{
			if(inv_is_full(_def.type)) { break; }
			array_push(global.inv, { item_id : _id, count : 1 });
		}
		_added++;
	}

	if(_added < _count && _notify)
	{
		create_text_simple("Your pockets is full Couldn't take " + _def.name + ".");
	}
	return _added;
}

///@param id
///@param [count]
function inv_remove(_id, _count = 1)
{
	inv_init();
	for(var i = 0; i < array_length(global.inv); i++)
	{
		if(global.inv[i].item_id == _id)
		{
			global.inv[i].count -= _count;
			if(global.inv[i].count <= 0) { array_delete(global.inv, i, 1); }
			return true;
		}
	}
	return false;
}

///@param id
function inv_count(_id)
{
	inv_init();
	for(var i = 0; i < array_length(global.inv); i++)
	{
		if(global.inv[i].item_id == _id) { return global.inv[i].count; }
	}
	return 0;
}

///@param id
function inv_has(_id)
{
	return inv_count(_id) > 0;
}

///@param type
function inv_get_list(_type)
{
	inv_init();
	var _list = [];
	for(var i = 0; i < array_length(global.inv); i++)
	{
		var _e = global.inv[i];
		var _def = item_get(_e.item_id);
		if(_def != undefined && _def.type == _type)
		{
			array_push(_list, { item_id : _e.item_id, count : _e.count, def : _def });
		}
	}
	return _list;
}

///@param type
function item_actions(_type)
{
	if(_type == "key") { return ["Info"]; }
	if(_type == "equip") { return ["Info", "Equip", "Drop"]; }
	return ["Info", "Use", "Drop"];
}

///@param id
///@param member
function inv_use_item(_id, _member)
{
	var _def = item_get(_id);
	if(_def == undefined || _def.use == undefined) { return ITEM_FAIL; }

	var _r = _def.use(_member, _def);
	if(_r == undefined) { _r = ITEM_USED; }
	if(_r == ITEM_USED) { inv_remove(_id, 1); }
	return _r;
}

///@param text
function create_text_simple(_text)
{
	with(instance_create_depth(0, 0, -9999, obj_theDialoge))
	{
		scr_text(_text);
	}
}

function scr_inv_step()
{
	var _list = inv_get_list(inv_types[inv_tab]);
	var _count = array_length(_list);
	inv_pos = clamp(inv_pos, 0, max(0, _count - 1));

	var _entry = undefined;
	if(_count > 0) { _entry = _list[inv_pos]; }
	if(_entry == undefined && inv_mode != 0) { inv_mode = 0; }

	if(inv_mode == 0)
	{
		var _lr = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
		if(_lr != 0)
		{
			inv_tab = (inv_tab + _lr + 3) mod 3;
			inv_pos = 0;
			inv_scroll = 0;
		}
		else if(_count > 0)
		{
			inv_pos += down_key - up_key;
			if(inv_pos >= _count) { inv_pos = 0; }
			if(inv_pos < 0) { inv_pos = _count - 1; }
		}

		if(accept_key && _entry != undefined)
		{
			inv_mode = 1;
			act_pos = 0;
		}
		else if(back_key)
		{
			screen = 0;
			target_x = list_x;
			target_y = list_y;
			target_w = list_w;
			target_h = list_h;
		}
	}
	else if(inv_mode == 1)
	{
		var _acts = item_actions(_entry.def.type);
		var _n = array_length(_acts);
		act_pos += down_key - up_key;
		if(act_pos >= _n) { act_pos = 0; }
		if(act_pos < 0) { act_pos = _n - 1; }

		if(back_key) { inv_mode = 0; }
		else if(accept_key)
		{
			switch(_acts[act_pos])
			{
				case "Info":
					create_text_simple(_entry.def.desc);
					break;
				case "Use":
				case "Equip":
					stats_pos = 0;
					stats_scroll = 0;
					inv_mode = 2;
					break;
				case "Drop":
					inv_remove(_entry.item_id, 1);
					inv_mode = 0;
					break;
			}
		}
	}
	else if(inv_mode == 2)
	{
		var _members = party_get_visible();
		var _mc = array_length(_members);
		if(_mc > 0)
		{
			stats_pos += down_key - up_key;
			if(stats_pos >= _mc) { stats_pos = 0; }
			if(stats_pos < 0) { stats_pos = _mc - 1; }
		}

		if(back_key) { inv_mode = 1; }
		else if(accept_key && _mc > 0)
		{
			var _r = inv_use_item(_entry.item_id, _members[stats_pos]);
			if(_r != ITEM_FAIL) { inv_mode = 0; }
		}
	}
}

///@param x
///@param y
///@param w
///@param h
function scr_inv_draw(_x, _y, _w, _h)
{
	var _lh = string_height("A");
	var _row = _lh + 4;
	var _pad = 8;

	var _list = inv_get_list(inv_types[inv_tab]);
	var _count = array_length(_list);
	inv_pos = clamp(inv_pos, 0, max(0, _count - 1));

	var _tx = _x + _pad;
	for(var t = 0; t < array_length(inv_tab_names); t++)
	{
		var _tc = c_gray;
		if(t == inv_tab) { _tc = c_yellow; }
		var _tl = inv_tab_names[t];
		var _cap = inv_capacity(inv_types[t]);
		if(_cap >= 0)
		{
			_tl += " " + string(array_length(inv_get_list(inv_types[t]))) + "/" + string(_cap);
		}
		draw_text_color(_tx, _y + _pad, _tl, _tc, _tc, _tc, _tc, 1);
		_tx += string_width(_tl) + 16;
	}

	var _top = _y + _pad + _lh + 10;
	var _rows = max(1, floor((_y + _h - _pad - _top) / _row));

	if(inv_pos < inv_scroll) { inv_scroll = inv_pos; }
	if(inv_pos >= inv_scroll + _rows) { inv_scroll = inv_pos - _rows + 1; }
	inv_scroll = clamp(inv_scroll, 0, max(0, _count - _rows));

	if(_count == 0)
	{
		draw_text_color(_x + _pad, _top, "(empty)", c_gray, c_gray, c_gray, c_gray, 1);
	}

	for(var i = 0; i < _rows; i++)
	{
		var _idx = inv_scroll + i;
		if(_idx >= _count) { break; }

		var _e = _list[_idx];
		var _c = c_white;
		if(_idx == inv_pos) { _c = c_yellow; }

		var _label = _e.def.name;
		if(INV_STACK_MAX > 1) { _label += " x" + string(_e.count); }

		var _ry = _top + i * _row;
		if(_idx == inv_pos) { draw_text_color(_x + _pad, _ry, ">", _c, _c, _c, _c, 1); }
		draw_text_color(_x + _pad + 8, _ry, _label, _c, _c, _c, _c, 1);
	}

	var _px = _x + floor(_w * 0.45);
	var _pw = _w - floor(_w * 0.45);

	var _tc2 = c_white;
	if(inv_scroll > 0)
	{
		draw_triangle_color(_px - 12, _top, _px - 15, _top + 4, _px - 9, _top + 4, _tc2, _tc2, _tc2, false);
	}
	if(inv_scroll + _rows < _count)
	{
		var _by = _top + _rows * _row - 4;
		draw_triangle_color(_px - 15, _by - 4, _px - 9, _by - 4, _px - 12, _by, _tc2, _tc2, _tc2, false);
	}

	draw_rectangle_color(_px - 4, _y + _pad, _px - 3, _y + _h - _pad, c_gray, c_gray, c_gray, c_gray, false);

	if(inv_mode == 1 && _count > 0)
	{
		var _acts = item_actions(_list[inv_pos].def.type);
		for(var a = 0; a < array_length(_acts); a++)
		{
			var _ac = c_white;
			if(a == act_pos) { _ac = c_yellow; }
			var _ay = _top + a * _row;
			if(a == act_pos) { draw_text_color(_px + 4, _ay, ">", _ac, _ac, _ac, _ac, 1); }
			draw_text_color(_px + 12, _ay, _acts[a], _ac, _ac, _ac, _ac, 1);
		}
	}

	if(inv_mode == 2)
	{
		scr_menu_draw_stats(_px, _y, _pw, _h);
	}
}

function item_use_equip(_m, _def)
{
	return equip_item(_m, _def.item_id);
}

///@param member
///@param item_id
function equip_item(_m, _id)
{
	var _def = item_get(_id);
	if(_def == undefined || _def.slot == "") { return ITEM_FAIL; }

	var _old = variable_struct_get(_m, _def.slot);

	inv_remove(_id, 1);

	if(_old != "")
	{
		if(inv_add(_old, 1, false) == 0)
		{
			inv_add(_id, 1, false);
			create_text_simple("Inventory is full!");
			return ITEM_FAIL;
		}
	}

	variable_struct_set(_m, _def.slot, _id);
	create_text_simple(_m.name + " equipped " + _def.name + ".");
	return ITEM_KEEP;
}

///@param member
///@param slot  "weapon" or "armor"
function party_unequip(_m, _slot)
{
	var _id = variable_struct_get(_m, _slot);
	if(_id == "") { return false; }
	if(inv_add(_id, 1) == 0) { return false; }
	variable_struct_set(_m, _slot, "");
	return true;
}

///@param member
///@param field  "atk" or "def"
function party_gear_bonus(_m, _field)
{
	var _b = 0;
	var _slots = ["weapon", "armor"];
	for(var i = 0; i < array_length(_slots); i++)
	{
		var _id = variable_struct_get(_m, _slots[i]);
		if(_id != "")
		{
			var _d = item_get(_id);
			if(_d != undefined) { _b += variable_struct_get(_d, _field); }
		}
	}
	return _b;
}

///@param member
function party_atk(_m) { return _m.atk + party_gear_bonus(_m, "atk"); }

///@param member
function party_def(_m) { return _m.def + party_gear_bonus(_m, "def"); }

///@param item_id
function item_name(_id)
{
	if(_id == "") { return "-"; }
	var _d = item_get(_id);
	if(_d == undefined) { return "?"; }
	return _d.name;
}
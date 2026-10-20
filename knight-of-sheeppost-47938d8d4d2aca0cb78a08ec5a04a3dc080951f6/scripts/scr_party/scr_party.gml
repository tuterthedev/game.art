function party_init()
{
	if(!variable_global_exists("party")) { global.party = []; }
}

///@param name
function party_find(_name)
{
	party_init();
	for(var i = 0; i < array_length(global.party); i++)
	{
		if(global.party[i].name == _name) { return global.party[i]; }
	}
	return undefined;
}

///@param name
///@param hp
///@param atk
///@param def
///@param portrait_sprite
function party_add(_name, _hp, _atk, _def, _portrait)
{
	party_init();
	if(party_find(_name) != undefined) { return; }
	array_push(global.party, {
		name : _name,
		hp : _hp,
		hp_max : _hp,
		atk : _atk,
		def : _def,
		portrait : _portrait,
		visible : true,
		weapon : "",
		armor : ""
	});
}

function party_get_visible()
{
	party_init();
	var _list = [];
	for(var i = 0; i < array_length(global.party); i++)
	{
		if(global.party[i].visible) { array_push(_list, global.party[i]); }
	}
	return _list;
}

///@param name
///@param field
///@param value
function party_set(_name, _field, _value)
{
	var _m = party_find(_name);
	if(_m == undefined) { return; }
	variable_struct_set(_m, _field, _value);
	_m.hp = clamp(_m.hp, 0, _m.hp_max);
}

///@param name
///@param field
///@param amount
function party_add_stat(_name, _field, _amount)
{
	var _m = party_find(_name);
	if(_m == undefined) { return; }
	variable_struct_set(_m, _field, variable_struct_get(_m, _field) + _amount);
	_m.hp = clamp(_m.hp, 0, _m.hp_max);
}

///@param name
function party_hide(_name)
{
	var _m = party_find(_name);
	if(_m != undefined) { _m.visible = false; }
}

///@param name
function party_show(_name)
{
	var _m = party_find(_name);
	if(_m != undefined) { _m.visible = true; }
}

///@param name
function party_remove(_name)
{
	party_init();
	for(var i = 0; i < array_length(global.party); i++)
	{
		if(global.party[i].name == _name)
		{
			array_delete(global.party, i, 1);
			return;
		}
	}
}

///@param x
///@param y
///@param w
///@param h
function scr_menu_draw_stats(_x, _y, _w, _h)
{
	var _list = party_get_visible();
	var _count = array_length(_list);
	if(_count == 0) { return; }

	var _border = 8;
	var _gap = 6;
	var _card_w = _w - _border * 2;
	var _card_h = scr_stat_card_height();

	var _rows = max(1, floor((_h - _border * 2 + _gap) / (_card_h + _gap)));

	if(stats_pos < stats_scroll) { stats_scroll = stats_pos; }
	if(stats_pos >= stats_scroll + _rows) { stats_scroll = stats_pos - _rows + 1; }
	stats_scroll = clamp(stats_scroll, 0, max(0, _count - _rows));

	for(var i = 0; i < _rows; i++)
	{
		var _idx = stats_scroll + i;
		if(_idx >= _count) { break; }

		var _cy = _y + _border + i * (_card_h + _gap);
		scr_draw_stat_card(_list[_idx], _x + _border, _cy, _card_w, _card_h, _idx == stats_pos);
	}

	var _cx = _x + _w / 2;
	var _tc = c_white;
	if(stats_scroll > 0)
	{
		draw_triangle_color(_cx, _y + 2, _cx - 3, _y + 6, _cx + 3, _y + 6, _tc, _tc, _tc, false);
	}
	if(stats_scroll + _rows < _count)
	{
		draw_triangle_color(_cx - 3, _y + _h - 6, _cx + 3, _y + _h - 6, _cx, _y + _h - 2, _tc, _tc, _tc, false);
	}
}

///@param member
///@param x
///@param y
///@param w
///@param h
///@param selected
function scr_draw_stat_card(_m, _x, _y, _w, _h, _selected)
{
	var _lh = string_height("A");
	var _c = c_white;
	var _top_h = max(36, _lh * 3 + 6);

	var _bc = c_white;
	if(_selected) { _bc = c_yellow; }

	draw_rectangle_color(_x, _y, _x + _w, _y + _h, c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(_x, _y, _x + _w, _y + _h, _bc, _bc, _bc, _bc, true);

	var _tx = _x + 4;
	if(_m.portrait != noone)
	{
		var _s = min(32 / sprite_get_width(_m.portrait), 32 / sprite_get_height(_m.portrait));
		draw_sprite_ext(_m.portrait, 0, _x + 2, _y + 2, _s, _s, 0, c_white, 1);
		_tx = _x + 38;
	}

	draw_text_color(_tx, _y + 4, _m.name, c_yellow, c_yellow, c_yellow, c_yellow, 1);
	draw_text_color(_tx, _y + 4 + _lh, "HP " + string(_m.hp) + "/" + string(_m.hp_max), _c, _c, _c, _c, 1);
	draw_text_color(_tx, _y + 4 + _lh * 2, "ATK " + string(party_atk(_m)) + "  DEF " + string(party_def(_m)), _c, _c, _c, _c, 1);

	draw_text_color(_x + 4, _y + _top_h + 2, "WPN " + item_name(_m.weapon), _c, _c, _c, _c, 1);
	draw_text_color(_x + 4, _y + _top_h + 2 + _lh, "ARM " + item_name(_m.armor), _c, _c, _c, _c, 1);
}

function scr_stat_card_height()
{
	var _lh = string_height("A");
	return max(36, _lh * 3 + 6) + _lh * 2 + 6;
}
function char_get(_id)
{
	switch(_id)
	{
		case "hero":
			return { name : "Hero", hp : 20, atk : 5, def : 2, portrait : spr_cooler_guy };}
	return undefined;
}

function party_add_id(_id)
{
	var _c = char_get(_id);
	if(_c == undefined) { return; }
	party_add(_c.name, _c.hp, _c.atk, _c.def, _c.portrait);
}
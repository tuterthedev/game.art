//shit
if(instance_exists(obj_main)){
	obj_th_ActWind.x = obj_main.x;
	obj_th_ActWind.y = obj_main.y;

	if (obj_main.sprite_index == obj_main.spr_a) { obj_th_ActWind.x -= 8; }
	if (obj_main.sprite_index == obj_main.spr_w) { obj_th_ActWind.y -= 8; }
	if (obj_main.sprite_index == obj_main.spr_d) { obj_th_ActWind.x += 8; }
	if (obj_main.sprite_index == obj_main.spr_s) { obj_th_ActWind.y += 8; } 
}
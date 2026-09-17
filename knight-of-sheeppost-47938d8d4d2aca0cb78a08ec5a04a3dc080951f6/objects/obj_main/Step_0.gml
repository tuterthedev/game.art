


if(obj_room_manager.fader <= 0){
	
	if(keyboard_check(ord("W"))){
		y -= spd* (!instance_place(x,y - spd,wall));
		sprite_index = spr_w
	}
	if(keyboard_check(ord("S"))){
		y += spd* (!instance_place(x,y + spd,wall));
		sprite_index = spr_s
	}
	if(keyboard_check(ord("A"))){
		x -= spd* (!instance_place(x - spd,y,wall));
		sprite_index = spr_a
	}
	if(keyboard_check(ord("D"))){
		x += spd* (!instance_place(x + spd,y,wall));
		sprite_index = spr_d
	}

	if(x = xprevious and y = yprevious){
		image_speed = 0;
		image_index = 0;
	
	}else {
		image_speed = 1;
	}
}




var _use = keyboard_check_pressed(ord("F"))


if _use and use_cooldown <= 0{
	var n = instance_nearest(x,y,obj_entity_par)
	if n and distance_to_object(n) < 5{
		n.use()
		if(n.use ){
			use_cooldown = 60
			
		}
		}
	
	}
use_cooldown -= 1
	



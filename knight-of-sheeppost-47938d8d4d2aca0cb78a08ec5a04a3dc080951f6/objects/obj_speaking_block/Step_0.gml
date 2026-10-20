var _s = id;

if(instance_exists(obj_th_ActWind) && !instance_exists(obj_menu) && !instance_exists(obj_theDialoge))
{
	if(position_meeting(obj_th_ActWind.x, obj_th_ActWind.y, id) && keyboard_check_pressed(ord("Z")))
	{
		create_textbox(text_id);
	}
}
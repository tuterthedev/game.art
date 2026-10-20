up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(ord("Z"));

back_key = keyboard_check_pressed(ord("X"));

width = lerp(width, target_w, 0.25);
height = lerp(height, target_h, 0.25);

x = lerp(x, target_x, 0.25);
y = lerp(y, target_y, 0.25);

if(abs(width - target_w) < 1) { width = target_w; }
if(abs(height - target_h) < 1) { height = target_h; }
if(abs(x - target_x) < 1) { x = target_x; }
if(abs(y - target_y) < 1) { y = target_y; }

if(instance_exists(obj_theDialoge)) { input_lock = 2; exit; }
if(input_lock > 0) { input_lock--; exit; }

if(screen == 2)
{
	scr_inv_step();
	exit;
}

if(screen == 1)
{
	var _count = array_length(party_get_visible());
	if(_count > 0)
	{
		stats_pos += down_key - up_key;
		if(stats_pos >= _count) { stats_pos = 0; }
		if(stats_pos < 0) { stats_pos = _count - 1; }
	}

	if(back_key)
	{
		screen = 0;
		target_w = list_w;
		target_h = list_h;
	}
	exit;
}

pos += down_key - up_key;
if pos >= op_leight {pos = 0};
if pos < 0 {pos = op_leight -1};

if accept_key {
	switch(pos){

	case 0:
		inv_tab = 0;
		inv_pos = 0;
		inv_scroll = 0;
		inv_mode = 0;
		screen = 2;
		target_x = floor(camera_get_view_x(view_camera[0])) + 4;
		target_y = floor(camera_get_view_y(view_camera[0])) + 4;
		target_w = camera_get_view_width(view_camera[0]) - 8;
		target_h = camera_get_view_height(view_camera[0]) - 8;

	
		
		
		break;

	case 1:
	stats_pos = 0;
	stats_scroll = 0;
	screen = 1;
	target_w = camera_get_view_width(view_camera[0]) / 2;
	target_h = floor(camera_get_view_y(view_camera[0])) + camera_get_view_height(view_camera[0]) - 4 - list_y;
	
	break;
	
		

	case 2:
		
		break;
		
	case 3:
		room_goto(main_menu)
	
		break;
		
	}
	
}
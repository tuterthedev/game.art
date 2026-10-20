if(instance_exists(obj_main) && !instance_exists(obj_th_ActWind)){instance_create_layer(obj_main.x,obj_main.y,obj_main.layer,obj_th_ActWind)}

key_acs = keyboard_check_pressed(ord("I"));
key_esc = keyboard_check_pressed(ord("Z"));

if(key_acs && instance_exists(obj_main) && obj_main.state == main_pl.idle && !instance_exists(obj_menu))
{
	cam_x = floor(camera_get_view_x(view_camera[0]));
	cam_y = floor(camera_get_view_y(view_camera[0]));

	instance_create_depth(cam_x + 20, cam_y + 20, -9000, obj_menu);
}
if(key_acs && instance_exists(obj_main) && obj_main.state == main_pl.inv && instance_exists(obj_menu))
{
	instance_destroy(obj_menu);
}
if(keyboard_check_pressed(ord("P"))) { inv_add("potion"); }
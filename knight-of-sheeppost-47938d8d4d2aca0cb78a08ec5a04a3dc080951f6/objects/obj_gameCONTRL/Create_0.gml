global.font_main = font_add("8bitoperator.ttf",8,false,false,32,127);

window_set_fullscreen(true)

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);

party_init();
if(array_length(global.party) == 0) { party_add_id("hero"); }

if(!variable_global_exists("inv"))
{
	inv_init();
	inv_add("potion", 2);
	inv_add("wood_sword");
	inv_add("leather_vest");
	inv_add("old_key");
}

width = 60;
height = 100;

screen = 0; 
list_w = width;
list_h = height;
target_w = width;
target_h = height;
stats_pos = 0;
stats_scroll = 0;

op_border = 8; 
op_space = 20;

pos = 0;

option[0] = "Items";
option[1] = "Stats";
option[2] = "Phone";
option[3] = "Quit";

op_leight =array_length(option);

show_debug_message("party exists: " + string(variable_global_exists("party")));
if(variable_global_exists("party"))
{
	show_debug_message("members: " + string(array_length(global.party)) + ", visible: " + string(array_length(party_get_visible())));
}

list_x = x;
list_y = y;
target_x = x;
target_y = y;
input_lock = 0;

inv_types = ["item", "equip", "key"];
inv_tab_names = ["Items", "Equip", "Key Items"];
inv_tab = 0;
inv_pos = 0;
inv_scroll = 0;
inv_mode = 0; // 0 - список, 1 - действия, 2 - выбор персонажа
act_pos = 0;
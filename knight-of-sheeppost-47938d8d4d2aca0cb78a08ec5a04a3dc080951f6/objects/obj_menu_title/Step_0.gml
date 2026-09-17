up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_space);

pos += down_key - up_key;
if pos >= op_leight {pos = 0};
if pos < 0 {pos = op_leight -1};

if accept_key {
	switch(pos){

	case 0:
		room_goto_next()
		break;

	case 1:
		room_goto(rooom_area3)

		break;

	case 2:
		game_end()
		break;
		
	case 3:
		room_goto(room_fight_test);
	}
	
}
function scr_set_defaults_for_test(){
	line_break_pos[0, page_number] = 9999;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0; 
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = 1;
	
	for(var c = 0 ; c < 999 ; c++)
	{
		col_1[c,page_number] = c_white
		col_2[c,page_number] = c_white
		col_3[c,page_number] = c_white
		col_4[c,page_number] = c_white
		
		float_text[c,page_number] = 0;
		float_dir[c,page_number] = c * 20;
		
		shake_text[c,page_number] = 0;
		shake_dir[c,page_number] = irandom(360);
		shake_time[c,page_number] = irandom(4);
	}
	
	
	
	txtb_spr[page_number] = spr_dialoge_window;
	
	snd[page_number] = mus_st_voice_norm;
}

//______________________ VFX ___________________________
///@param 1st_char
///@param last_char
///@param c_1
///@param c_2
///@param c_3
///@param c_4
function scr_text_color(_start, _end , _col1, _col2, _col3, _col4){
	for(var c = _start; c <= _end; c++)
	{
		col_1[c, page_number - 1] = _col1;
		col_2[c, page_number - 1] = _col2;
		col_3[c, page_number - 1] = _col3;
		col_4[c, page_number - 1] = _col4;
	}


}
///@param 1st_char
///@param last_char
function scr_text_float (_start , _end ){

	for(var c = _start; c <= _end; c++)
	{
		float_text[c, page_number - 1] = true;
		
	}


}

///@param 1st_char
///@param last_char
function scr_text_shake (_start , _end ){

	for(var c = _start; c <= _end; c++)
	{
		shake_text[c, page_number - 1] = true;
		
	}


}






///@param text
///@param [portrait]
///@param [side]
function scr_text(_text){
	
	scr_set_defaults_for_test() 
	
	text[page_number] = _text;
	
	
	if (argument_count > 1)
	{
		switch(argument[1])
		{
			case "dev":
			speaker_sprite[page_number] = spr_cooler_guy;
			txtb_spr[page_number] = spr_dialoge_window;
			snd[page_number] = mus_st_voice_norm;
				break;
		}
	}
	if(argument_count > 2)
	{
		speaker_side[page_number] = argument[2];
	}
	
	page_number++;
	
	
	


}

///@param option
///@param link_id
function scr_option(_option, _link_id)
{
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	option_number ++;
}



///@param text id

function create_textbox(_text_id){
	with(instance_create_depth(0,0, - 9999, obj_theDialoge))
	{
		scr_game_text(_text_id);
	}
	

	
}
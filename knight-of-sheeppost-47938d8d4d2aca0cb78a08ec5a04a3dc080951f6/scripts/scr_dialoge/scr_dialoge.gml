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
	}
	
	
	
	txtb_spr[page_number] = spr_dialoge_window;
	
	snd[page_number] = mus_st_voice_norm;
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
function src_option(_option, _link_id)
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
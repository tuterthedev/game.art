depth = -999999;


textbox_width = 200;
textbox_height = 90;
border = 10;
line_sep = 20;
line_width = textbox_width - border * 2;
txtb_spr[0] = spr_dialoge_window;
txtb_img = 0;
txtb_img_spd = 0;

page = 0;
page_number = 0;

text[0] = "";
text_lenght[0] = string_length(text[0]);



char[0,0] = "";
char_x[0,0] = 0;
char_y[0,0] = 0;



draw_char = 0;
text_spd = 1;

option[0] = "";
option_link_id[0] = -1;
option_pos = 0; 
option_number = 0;

setup = false;

snd_delay = 3;
snd_count = snd_delay;

//effects
scr_set_defaults_for_test()
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 16;

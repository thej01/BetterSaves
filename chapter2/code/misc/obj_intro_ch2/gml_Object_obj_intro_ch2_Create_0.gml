con = 0;
timer = 0;
snd_free_all();
var CH = string(global.chapter);
files_exist = scr_chapter_save_file_exists(global.chapter) || scr_completed_chapter_any_slot(global.chapter)
show_queen = false;
queen_sprite = spr_queen_wireframe_rotate;
queen_sprite_index = 0;
queen_siner = 0;
queen_animate = true;
queen_y_pos = -100;
queen_alpha = 0;
init = 0;
type = 0;

var old_file = cur_file(MENUCOORD[3], false)
var new_file = scr_bettersaves_copy(old_file, cur_file(MENUCOORD[2], false))
ds_list_set(savefiles, ds_list_find_index(savefiles, old_file), new_file)
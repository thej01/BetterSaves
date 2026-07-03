var old_file = cur_file(MENUCOORD[3], false)
var new_file = scr_bettersaves_copy(old_file, cur_file(MENUCOORD[2], false))
ds_list_set(savefiles, ds_list_find_index(savefiles, old_file), new_file)

with (obj_event_manager)
    trigger_event(UnknownEnum.Value_0, UnknownEnum.Value_28);

enum UnknownEnum
{
    Value_0,
    Value_28 = 28
}

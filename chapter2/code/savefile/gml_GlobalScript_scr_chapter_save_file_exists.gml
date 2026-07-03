function scr_chapter_save_file_exists(chapter)
{
    return scr_bettersaves_any_saves_simple(chapter, 0);
}

function scr_chapter_save_file_exists_in_slot(chapter, slot)
{
    return ossafe_file_exists(scr_bettersaves_file_name(slot, false, chapter));
}

function scr_completed_chapter_any_slot(chapter)
{
    return scr_bettersaves_any_saves_simple(chapter, 1);
}

function scr_completed_chapter_in_slot(chapter, slot)
{
    return ossafe_file_exists(scr_bettersaves_file_name(slot + 3, true, chapter));
}

function scr_get_ini_value(chapter, slot, key, completion = false)
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_read_real(scr_bettersaves_ini_name(slot, completion, chapter), key, 0);
    ossafe_ini_close();
    return _ini_value;
}

function scr_fought_secret_boss_any_slot(chapter, destroy_list = true)
{
    var _fought = false;
    scr_bettersaves_get_all_saves(chapter, 0, false)
    for (var i = 0; i < ds_list_size(savefiles_normal); i++)
    {
        var _slot = ds_list_find_value(savefiles_normal, i);
        var _result = scr_get_ura_value(chapter, _slot);
        
        if (_result > 0)
        {
            _fought = true;
            break;
        }
    }
    if destroy_list
        ds_list_destroy(savefiles_normal)
    
    return _fought;
}

function scr_get_ini_value_all_slots(chapter, key, destroy_list = true)
{
    var _list = [];
    scr_bettersaves_get_all_saves(chapter, -1, false)
    ossafe_ini_open(scr_bettersaves_get_drini());

    for (var i = 0; i < ds_list_size(savefiles); i++)
    {
        var file = ds_list_find_value(savefiles, i)
        _list[i][0] = i;
        _list[i][1] = ini_read_real(scr_bettersaves_ini_from_struct(file), key, 0);
    }

    if (destroy_list)
        ds_list_destroy(savefiles)
    
    ossafe_ini_close();
    return _list;
}

function scr_get_ura_value(chapter, file_struct)
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_read_real("URA", scr_bettersaves_ura(file_struct, chapter), 0);
    ossafe_ini_close();
    return _ini_value;
}

function scr_set_ura_value(chapter, file_struct, result)
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_write_real("URA", scr_bettersaves_ura(file_struct, chapter), result);
    ossafe_ini_close();
    return _ini_value;
}

function scr_store_ura_result(chapter, file_struct, arg2)
{
    if (arg2 == 0)
        exit;
    
    var current_result = scr_get_ura_value(chapter, file_struct);
    var new_result = arg2;
    
    if ((arg2 + current_result) == 3)
        new_result = 3;
    
    scr_set_ura_value(chapter, file_struct, new_result);
}

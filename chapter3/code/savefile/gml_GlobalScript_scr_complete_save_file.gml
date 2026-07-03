function scr_complete_save_file()
{
    _remfilechoice = global.filechoice;
    global.filechoice += 3;
    scr_set_ini_value(global.chapter, global.filechoice, "SideB", scr_sideb_active(), true);
    scr_save(global.bettersaves_save_types.completion);
    global.filechoice = _remfilechoice;
}

function scr_chapter_save_file_exists(chapter)
{
    return scr_bettersaves_any_saves_simple(chapter, 0);
}

function scr_completed_chapter(slot)
{
    return ossafe_file_exists(scr_bettersaves_file_name(slot + 3, true, chapter));
}

function scr_completed_chapter_any_slot(chapter)
{
    return scr_bettersaves_any_saves_simple(chapter, 1);
}

function scr_get_secret_boss_result(arg0)
{
    var fought_flag = scr_get_secret_boss_flag(arg0);
    return global.flag[fought_flag];
}

function scr_defeated_secret_boss_any_slot(chapter)
{
    var _fought_boss = scr_fought_secret_boss_any_slot(chapter, false);
    var _defeated = false;
    
    if (_fought_boss)
    {
        for (var i = 0; i < ds_list_size(savefiles_normal); i++)
        {
            var _slot = ds_list_find_value(savefiles_normal, i)
            var _result = scr_get_ura_value(chapter, _slot);
            
            if (_result == 1 || _result == 3)
            {
                _defeated = true;
                break;
            }
        }
    }
    ds_list_destroy(savefiles_normal)

    return _defeated;
}

function scr_spared_secret_boss_any_slot(chapter)
{
    var _fought_boss = scr_fought_secret_boss_any_slot(chapter, false);
    var _spared = false;
    
    if (_fought_boss)
    {
        for (var i = 0; i < ds_list_size(savefiles_normal); i++)
        {
            var _slot = ds_list_find_value(savefiles_normal, i);
            var _result = scr_get_ura_value(chapter, _slot);
            
            if (_result >= 2)
            {
                _spared = true;
                break;
            }
        }
    }
    ds_list_destroy(savefiles_normal)
    
    return _spared;
}

function scr_fought_secret_boss(arg0)
{
    return scr_get_secret_boss_result(arg0) > 0;
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

function scr_get_secret_boss_flag(arg0)
{
    var fought_flag = 241;
    
    switch (arg0)
    {
        case 1:
            fought_flag = 241;
            break;
        
        case 2:
            fought_flag = 571;
            break;
        
        case 3:
            fought_flag = 1047;
            break;
        
        default:
            break;
    }
    
    return fought_flag;
}

function scr_enable_chapter_skip(arg0)
{
    var _skip_flag = 38;
    
    switch (arg0)
    {
        case 2:
            _skip_flag = 39;
            break;
        
        case 3:
            _skip_flag = 40;
            break;
        
        default:
            break;
    }
    
    global.tempflag[_skip_flag] = 1;
}

function scr_get_knight_total_loss_count()
{
    var _times_lost = 0;
    var _chapter = 3;
    var _fought_boss = scr_fought_secret_boss_any_slot(_chapter, false);
    
    if (_fought_boss)
    {
        for (var i = 0; i < ds_list_size(savefiles_normal); i++)
        {
            var _slot = ds_list_find_value(savefiles_normal, i);
            var _result = scr_get_ura_value(_chapter, _slot);
            
            if (_result == 2)
                _times_lost++;
        }
    }
    ds_list_destroy(savefiles_normal)
    
    return _times_lost;
}

function scr_get_knight_total_attempts()
{
    var _times_attempted = 0;
    var _chapter = 3;
    var _fought_boss = scr_fought_secret_boss_any_slot(_chapter, false);
    
    if (_fought_boss)
    {
        for (var i = 0; i < ds_list_size(savefiles_normal); i++)
        {
            var _slot =  ds_list_find_value(savefiles_normal, i);
            var _result = scr_get_ura_value(_chapter, _slot);
            
            if (_result > 0)
                _times_attempted++;
        }
    }
    ds_list_destroy(savefiles_normal)
    
    return _times_attempted;
}

function scr_set_ini_value(chapter, slot, key, val, completion = false)
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_write_real(scr_bettersaves_ini_name(slot, completion, chapter), key, val);
    ossafe_ini_close();
    return _ini_value;
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

function scr_get_ini_value(chapter, slot, key, completion = false)
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_read_real(scr_bettersaves_ini_name(slot, completion, chapter), key, 0);
    ossafe_ini_close();
    return _ini_value;
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

function scr_get_vhs_ini_value()
{
    var _ini_file = ossafe_ini_open(scr_bettersaves_get_drini());
    var _ini_value = ini_read_real("VHS", "watched", 0);
    ossafe_ini_close();
    return _ini_value;
}

function scr_set_vhs_ini_value(arg0)
{
    var iniwrite = ossafe_ini_open(scr_bettersaves_get_drini());
    ini_write_real("VHS", "watched", arg0);
    ossafe_ini_close();
    ossafe_savedata_save();
}

function scr_save(save_type = global.bettersaves_save_types.normal)
{
    scr_saveprocess(global.filechoice, save_type);
    filechoicebk2 = global.filechoice;
    global.filechoice = 9;
    scr_saveprocess(9, global.bettersaves_save_types.temp);
    global.filechoice = filechoicebk2;

    var fields = scr_bettersaves_get_save_field(global.filechoice, save_type)
    iniwrite = ossafe_ini_open(scr_bettersaves_get_drini());
    ini_write_string(fields.ini_section, "Name", global.truename);
    ini_write_real(fields.ini_section, "Level", global.lv);
    ini_write_real(fields.ini_section, "Love", global.llv);
    ini_write_real(fields.ini_section, "Time", global.time);
    ini_write_real(fields.ini_section, "Date", date_current_datetime());
    ini_write_real(fields.ini_section, "Room", scr_get_id_by_room_index(room));
    ini_write_real(fields.ini_section, "InitLang", global.flag[912]);
    var uraboss = 0;
    
    if (global.chapter == 1)
    {
        if (global.flag[241] == 6)
            uraboss = 1;
        else if (global.flag[241] == 7)
            uraboss = 2;
    }
    else
    {
        uraboss = scr_get_secret_boss_result(global.chapter)
    }
    
    ini_write_real(fields.ini_section, "UraBoss", uraboss);
    ini_write_string(fields.ini_section, "Version", global.versionno);
    scr_bettersaves_save_info(fields.ini_section)
    ossafe_ini_close();
    scr_store_ura_result(global.chapter, fields.file_struct, uraboss);
    ossafe_ini_open(fields.keyconfig);
    
    for (i = 0; i < 10; i += 1)
        ini_write_real("KEYBOARD_CONTROLS", string(i), global.input_k[i]);
    
    for (i = 0; i < 10; i += 1)
        ini_write_real("GAMEPAD_CONTROLS", string(i), global.input_g[i]);
    
    ini_write_real("SHOULDERLB_REASSIGN", "SHOULDERLB_REASSIGN", obj_gamecontroller.gamepad_shoulderlb_reassign);
    ossafe_ini_close();
    ossafe_savedata_save();
    if (save_type == global.bettersaves_save_types.completion)
        scr_bettersaves_on_completion_data_made(scr_bettersaves_file_struct(global.filechoice, true))
}

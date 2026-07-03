function scr_84_load_ini()
{
    // I'm pretty sure in bettersaves, while this function does still run, doesn't actually do anything with the arrays here.
    // I think I only left it here just so the game didn't complain about missing arrays or anything.
    for (i = 0; i < 3; i += 1)
        FILE[i] = 0;
    
    for (i = 0; i < 3; i += 1)
    {
        FILE[i] = 0;
        NAME[i] = scr_84_get_lang_string("DEVICE_MENU_slash_Create_0_gml_97_0"); // [EMPTY]
        TIME[i] = 0;
        PLACE[i] = "------------";
        LEVEL[i] = 0;
        TIME_STRING[i] = "--:--";
        INITLANG[i] = 0;
    }
    
    if (ossafe_file_exists("filech1_0"))
    {
        FILE[0] = 1;
        NAME[0] = scr_84_get_lang_string("DEVICE_MENU_slash_Create_0_gml_107_0"); // FILE0
    }
    
    if (ossafe_file_exists("filech1_1"))
    {
        FILE[1] = 1;
        NAME[1] = scr_84_get_lang_string("DEVICE_MENU_slash_Create_0_gml_112_0"); // FILE1
    }
    
    if (ossafe_file_exists("filech1_2"))
    {
        FILE[2] = 1;
        NAME[2] = scr_84_get_lang_string("DEVICE_MENU_slash_Create_0_gml_117_0"); // FILE2
    }
    
    // These two lines are the only changes
    if (ossafe_file_exists(scr_bettersaves_get_drini()))
    {
        ossafe_ini_open(scr_bettersaves_get_drini());
        
        for (i = 0; i < 3; i += 1)
        {
            if (FILE[i] == 1)
            {
                var room_id = ini_read_real(scr_ini_chapter(global.chapter, i), "Room", scr_get_id_by_room_index(room));
                
                if (room_id < 10000)
                {
                    var valid_room_index = scr_get_valid_room(global.chapter, room_id);
                    room_id = scr_get_id_by_room_index(valid_room_index);
                }
                
                var room_index = scr_get_room_by_id(room_id);
                PLACE[i] = scr_roomname(room_index);
                TIME[i] = ini_read_real("G" + string(i), "Time", 0);
                NAME[i] = ini_read_string("G" + string(i), "Name", "------");
                LEVEL[i] = 1;
                INITLANG[i] = ini_read_real("G" + string(i), "InitLang", 0);
                TIME_SECONDS_TOTAL[i] = floor(TIME[i] / 30);
                TIME_MINUTES[i] = floor(TIME_SECONDS_TOTAL[i] / 60);
                TIME_SECONDS[i] = TIME_SECONDS_TOTAL[i] - (TIME_MINUTES[i] * 60);
                TIME_SECONDS_STRING[i] = string(TIME_SECONDS[i]);
                
                if (TIME_SECONDS[i] == 0)
                    TIME_SECONDS_STRING[i] = "00";
                
                if (TIME_SECONDS[i] < 10 && TIME_SECONDS[i] >= 1)
                    TIME_SECONDS_STRING[i] = "0" + string(TIME_SECONDS[i]);
                
                TIME_STRING[i] = scr_timedisp(TIME[i]);
            }
        }
        
        ossafe_ini_close();
        ossafe_savedata_save();
    }
}

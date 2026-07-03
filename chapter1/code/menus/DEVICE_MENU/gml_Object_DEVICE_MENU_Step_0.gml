if (!input_enabled)
    exit;

if (MENU_NO == 1 || MENU_NO == 4 || MENU_NO == 6 || MENU_NO == 7)
{

    var sel_type = 0
    var new_file = false
    if (MENU_NO == 1 && MENUCOORD[0] == get_file_amt())
        new_file = true
    else
        sel_type = MENU_NO == 1 && cur_file(MENUCOORD[0], false).exists
    var minl = 0
    var maxr = sel_type ? 3 : 1

    // this is so peoples muscle memory still works
    var wrap = MENU_NO == 7
    if (left_p())
    {
        MENUCOORD[MENU_NO]--
        if (MENUCOORD[MENU_NO] < minl)
        {
            if wrap
            {
                MOVENOISE = true
                MENUCOORD[MENU_NO] = maxr
            }
            else
                MENUCOORD[MENU_NO] = minl
        }
        else
            MOVENOISE = true
    }
    
    if (right_p())
    {
        MENUCOORD[MENU_NO]++
        if (MENUCOORD[MENU_NO] > maxr)
        {
            if wrap
            {
                MOVENOISE = true
                MENUCOORD[MENU_NO] = minl
            }
            else
                MENUCOORD[MENU_NO] = minl
        }
        else
            MOVENOISE = true
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        ONEBUFFER = 2;
        TWOBUFFER = 2;
        SELNOISE = 1;
        
        if (MENUCOORD[MENU_NO] == 0)
        {
            if (MENU_NO == 1)
            {
                scr_gamestart()
                if !new_file
                {
                    var file = cur_file(MENUCOORD[0], false)
                    if (file.exists)
                    {
                        global.filechoice = MENUCOORD[0];
                        scr_windowcaption(scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_35_0")); // THE DARK
                        snd_free_all();
                        obj_loadscreen.loaded = true;
                        input_enabled = false;
                        
                        if (ossafe_file_exists(get_key_file(global.filechoice)))
                        {
                            ossafe_ini_open(get_key_file(global.filechoice));
                            
                            for (var i = 0; i < 10; i += 1)
                            {
                                readval = ini_read_real("KEYBOARD_CONTROLS", string(i), -1);
                                
                                if (readval != -1)
                                    global.input_k[i] = readval;
                            }
                            
                            for (var i = 0; i < 10; i += 1)
                            {
                                readval = ini_read_real("GAMEPAD_CONTROLS", string(i), -1);
                                
                                if (readval != -1)
                                    global.input_g[i] = readval;
                            }
                            
                            readval = ini_read_real("SHOULDERLB_REASSIGN", "SHOULDERLB_REASSIGN", obj_gamecontroller.gamepad_shoulderlb_reassign);
                            
                            if (readval != -1)
                                obj_gamecontroller.gamepad_shoulderlb_reassign = readval;
                            
                            global.button0 = global.input_g[4];
                            global.button1 = global.input_g[5];
                            global.button2 = global.input_g[6];
                            
                            if (global.is_console)
                            {
                                global.screen_border_id = ini_read_string("BORDER", "TYPE", "Dynamic");
                                var _disable_border = global.screen_border_id == "None" || global.screen_border_id == "なし";
                                scr_enable_screen_border(!_disable_border);
                            }
                            
                            ossafe_ini_close();
                            ossafe_savedata_save();
                        }
                        else if (ossafe_file_exists(get_config_file(global.filechoice)))
                        {
                            ossafe_ini_open(get_config_file(global.filechoice));
                            
                            for (var i = 0; i < 10; i += 1)
                            {
                                readval = ini_read_real("KEYBOARD_CONTROLS", string(i), -1);
                                
                                if (readval != -1)
                                    global.input_k[i] = readval;
                            }
                            
                            for (var i = 0; i < 10; i += 1)
                            {
                                readval = ini_read_real("GAMEPAD_CONTROLS", string(i), -1);
                                
                                if (readval != -1)
                                    global.input_g[i] = readval;
                            }
                            
                            readval = ini_read_real("SHOULDERLB_REASSIGN", "SHOULDERLB_REASSIGN", obj_gamecontroller.gamepad_shoulderlb_reassign);
                            
                            if (readval != -1)
                                obj_gamecontroller.gamepad_shoulderlb_reassign = readval;
                            
                            global.input_g[0] = gp_padd;
                            global.input_g[1] = gp_padr;
                            global.input_g[2] = gp_padu;
                            global.input_g[3] = gp_padl;
                            global.input_g[4] = global.button0;
                            global.input_g[5] = global.button1;
                            global.input_g[6] = global.button2;
                            global.input_g[7] = 999;
                            global.input_g[8] = 999;
                            global.input_g[9] = 999;
                            global.button0 = global.input_g[4];
                            global.button1 = global.input_g[5];
                            global.button2 = global.input_g[6];
                            
                            if (global.is_console)
                            {
                                global.screen_border_id = ini_read_string("BORDER", "TYPE", "Dynamic");
                                var _disable_border = global.screen_border_id == "None" || global.screen_border_id == "なし";
                                scr_enable_screen_border(!_disable_border);
                            }
                            
                            ossafe_ini_close();
                            ossafe_savedata_save();
                            
                            if (!global.is_console)
                            {
                                ossafe_ini_open(get_key_file(global.filechoice));
                                
                                for (var i = 0; i < 10; i++)
                                    ini_write_real("KEYBOARD_CONTROLS", string(i), global.input_k[i]);
                                
                                for (var i = 0; i < 10; i++)
                                    ini_write_real("GAMEPAD_CONTROLS", string(i), global.input_g[i]);
                                
                                ini_write_real("SHOULDERLB_REASSIGN", "SHOULDERLB_REASSIGN", obj_gamecontroller.gamepad_shoulderlb_reassign);
                                ossafe_ini_close();
                            }
                        }
                        
                        if (os_type == os_ps5)
                        {
                            with (obj_event_manager)
                                trigger_event(UnknownEnum.Value_2, UnknownEnum.Value_0);
                        }
                    }
                }
                
                if (new_file || !file.exists)
                {
                    if (os_type == os_ps5)
                    {
                        with (obj_event_manager)
                            trigger_event(UnknownEnum.Value_2, UnknownEnum.Value_0);
                    }
                    
                    global.filechoice = MENUCOORD[0];
                    scr_bettersaves_chapter_start()
                }
            }
            
            if (MENU_NO == 4)
            {
                if (TYPE == 0)
                {
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_74_0"); // IT CONFORMED TO THE REFLECTION.
                    
                    if (NAME[0] == NAME[1] && NAME[1] == NAME[2])
                    {
                        if (TIME[0] == TIME[1] && TIME[1] == TIME[2])
                        {
                            if (PLACE[0] == PLACE[1] && PLACE[1] == PLACE[2])
                                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_77_0"); // WHAT AN INTERESTING BEHAVIOR.
                        }
                    }
                }
                
                event_user(5);
                
                if (TYPE == 0)
                {
                    if (NAME[0] == NAME[1] && NAME[1] == NAME[2])
                    {
                        if (TIME[0] == TIME[1] && TIME[1] == TIME[2])
                        {
                            if (PLACE[0] == PLACE[1] && PLACE[1] == PLACE[2] && TEMPCOMMENT != scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_86_0")) // WHAT AN INTERESTING BEHAVIOR.
                                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_86_1"); // PREPARATIONS ARE COMPLETE.
                        }
                    }
                }
                
                if (TYPE == 1)
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_91_0"); // Copy complete.
                
                MESSAGETIMER = 90;
                SELNOISE = 0;
                DEATHNOISE = 1;
                MENU_NO = 0;
                MENUCOORD[MENU_NO] = MENUCOORD[3]
            }

            if (MENU_NO == 6 || MENU_NO == 7)
            {
                if (TYPE == 0)
                {
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_156_0"); // THEN IT WAS SPARED.
                    
                    if (THREAT >= 10)
                    {
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_159_0"); // VERY INTERESTING.
                        THREAT = 0;
                    }
                    
                    MESSAGETIMER = 90;
                }
                MENU_NO = 1
            }
            
            if (MENU_NO == 6)
            {
                THREAT += 1;
                MENU_NO = 7;
                MENUCOORD[7] = 0;
            }
        }
        else if (MENUCOORD[MENU_NO] == 1)
        {
            if (MENU_NO == 4 && TYPE == 0)
            {
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_149_0"); // IT RETAINED ITS ORIGINAL SHAPE.
                MESSAGETIMER = 90;
            }

            if (MENU_NO == 7)
            {
                var file = cur_file(MENUCOORD[5], false)
                var push = scr_bettersaves_file_delete(file, savefiles)

                if (push && MENUCOORD[0] == get_file_amt())
                    MENUCOORD[0] -= 1
                
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_126_0"); // IT WAS AS IF IT WAS NEVER THERE AT ALL.
                
                if (TYPE == 1)
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_127_0"); // Erase complete.
                
                MESSAGETIMER = 90;
                SELNOISE = 0;
                DEATHNOISE = 1;
                MENU_NO = 0;
                
                with (obj_event_manager)
                    trigger_event(UnknownEnum.Value_0, UnknownEnum.Value_29);
            }
            
            if (sel_type)
            {
                MENUCOORD[2] = MENUCOORD[0]
                MENUCOORD[3] = MENUCOORD[0]
                MENU_NO = 3
            }
            else
            {
                if (MENU_NO == 7)
                    MENU_NO = 1
                else
                    MENU_NO = 0;
            }
                
        }
        else if (MENUCOORD[MENU_NO] == 2)
        {
            if (sel_type)
            {
                MENU_NO = 7
                THREAT += 1;
                MENUCOORD[7] = 1
                MENUCOORD[5] = MENUCOORD[0]
            }
        }
        else if MENUCOORD[MENU_NO] == 3
        {
            if (sel_type)
                MENU_NO = 0
        }
    }
    
    if (button2_p() && TWOBUFFER < 0)
    {
        ONEBUFFER = 1;
        TWOBUFFER = 1;
        BACKNOISE = 1;
        
        if (MENU_NO == 1)
            MENU_NO = 0;
        
        if (MENU_NO == 4)
            MENU_NO = 3;
        
        if (MENU_NO == 6)
            MENU_NO = 5;
        
        if (MENU_NO == 7)
            MENU_NO = 1;
    }
}

if MENU_NO == bottom_menu_copy_ver
{
    if down_p()
    {
        MOVENOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = 3
        MENUCOORD[MENU_NO] = -1
    }

    if button1_p()
    {
        SELNOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = 0
        MENUCOORD[MENU_NO] = 0
    }

    if button2_p()
    {
        BACKNOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = 0
        MENUCOORD[MENU_NO] = 0
    }
}

if (MENU_NO == 2 || MENU_NO == 3 || MENU_NO == 5)
{
    if (down_p())
    {
        var off = MENU_NO == 3 ? 1 : 0
        if (MENUCOORD[MENU_NO] < (get_file_amt() - 1) + off)
        {
            MENUCOORD[MENU_NO] += 1;
            MOVENOISE = true;
        }
    }
    
    if (up_p())
    {
        if (MENUCOORD[MENU_NO] > 0)
        {
            MENUCOORD[MENU_NO] -= 1;
            MOVENOISE = true;
        }
        else
        {
            ONEBUFFER = 1
            TWOBUFFER = 1
            MENU_NO = bottom_menu_copy_ver
            MOVENOISE = true;
        }
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        // copy into new file
        if (MENUCOORD[MENU_NO] == get_file_amt())
        {
            if (MENU_NO == 3)
            {
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_225_0"); // THE DIVISION IS COMPLETE.
                MESSAGETIMER = 90;
                
                if (TYPE == 1)
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_227_0"); // Copy complete.
                
                DEATHNOISE = 1;
                MENU_NO = 0;
                MENUCOORD[MENU_NO] = MENUCOORD[3]
                ONEBUFFER = 2;
                TWOBUFFER = 2;
                var my_file = scr_bettersaves_file_struct(get_file_amt(), false)
                my_file.exists = false
                scr_bettersaves_get_file_meta(my_file)
                var new_file = scr_bettersaves_copy(my_file, cur_file(MENUCOORD[2], false))
                ds_list_add(savefiles, new_file)
            }
        }
        else if (MENUCOORD[MENU_NO] < get_file_amt()) 
        {
            if (MENU_NO == 3)
            {
                if (MENUCOORD[2] != MENUCOORD[3])
                {
                    if cur_file(MENUCOORD[MENU_NO], false).exists
                    {
                        TWOBUFFER = 2;
                        ONEBUFFER = 2;
                        SELNOISE = 1;
                        MENUCOORD[4] = 0;
                        MENU_NO = 4;
                    }
                    else
                    {
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_225_0"); // THE DIVISION IS COMPLETE.
                        MESSAGETIMER = 90;
                        
                        if (TYPE == 1)
                            TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_227_0"); // Copy complete.
                        
                        DEATHNOISE = 1;
                        MENU_NO = 0;
                        MENUCOORD[MENU_NO] = MENUCOORD[3]
                        ONEBUFFER = 2;
                        TWOBUFFER = 2;
                        event_user(5);
                    }
                }
                else
                {
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_238_0"); // IT IS IMMUNE TO ITS OWN IMAGE.
                    
                    if (TYPE == 1)
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_239_0"); // You can't copy there.
                    
                    MESSAGETIMER = 90;
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                    BACKNOISE = 1;
                }
            }
            
            if (MENU_NO == 2)
            {
                if cur_file(MENUCOORD[MENU_NO], false).exists
                {
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                    SELNOISE = 1;
                    MENUCOORD[3] = 0;
                    MENU_NO = 3;
                }
                else
                {
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_261_0"); // IT IS BARREN AND CANNOT BE COPIED.
                    
                    if any_files()
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_264_0"); // BUT THERE WAS NOTHING LEFT TO COPY.
                    
                    if (TYPE == 1)
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_266_0"); // It can't be copied.
                    
                    MESSAGETIMER = 90;
                    BACKNOISE = 1;
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                }
            }
            
            if (MENU_NO == 5)
            {
                if cur_file(MENUCOORD[MENU_NO], false).exists
                {
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                    SELNOISE = 1;
                    MENUCOORD[6] = 0;
                    MENU_NO = 6;
                }
                else
                {
                    TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_289_0"); // BUT IT WAS ALREADY GONE.
                    
                    if any_files()
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_292_0"); // BUT THERE WAS NOTHING LEFT TO ERASE.
                    
                    if (TYPE == 1)
                        TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Step_0_gml_294_0"); // There's nothing to erase.
                    
                    MESSAGETIMER = 90;
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                    BACKNOISE = 1;
                }
            }
        }
        
        if (MENUCOORD[MENU_NO] == 3)
        {
            TWOBUFFER = 2;
            ONEBUFFER = 2;
            SELNOISE = 1;
            MENU_NO = 0;
        }
    }
    
    if (button2_p() && TWOBUFFER < 0)
    {
        TWOBUFFER = 2;
        ONEBUFFER = 2;
        BACKNOISE = 1;
        
        if (MENU_NO == 2 || MENU_NO == 5)
            MENU_NO = 0;
        
        if (MENU_NO == 3)
            MENU_NO = 1;
    }
}

if (MENU_NO == bottom_menu)
{
    var memloc = MENUCOORD[bottom_menu];
    
    if (up_p())
    {

    }
    
    if (right_p())
    {
        if (MENUCOORD[bottom_menu] >= bottom_menu_chselect && MENUCOORD[bottom_menu] < bottom_menu_quit)
        {
            MOVENOISE = 1;
            MENUCOORD[bottom_menu] += 1;
        }
        else if (MENUCOORD[bottom_menu] == bottom_menu_quit)
        {
            MOVENOISE = 1;
            MENUCOORD[bottom_menu] = bottom_menu_chselect;
        }
    }
    
    if (left_p())
    {
        if (MENUCOORD[bottom_menu] >= bottom_menu_chselect && MENUCOORD[bottom_menu] <= bottom_menu_quit)
        {
            MOVENOISE = 1;
            MENUCOORD[bottom_menu] -= 1;
            
            if (MENUCOORD[bottom_menu] < bottom_menu_chselect)
                MENUCOORD[bottom_menu] = bottom_menu_quit;
        }
    }
    
    if (global.is_console)
    {
        if (MENUCOORD[bottom_menu] == bottom_menu_quit)
        {
            MENUCOORD[bottom_menu] = memloc;
            MOVENOISE = false;
        }
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        /*if (MENUCOORD[bottom_menu] == bottom_menu_copy)
        {
            MENUCOORD[2] = 0;
            ONEBUFFER = 1;
            TWOBUFFER = 1;
            MENU_NO = 2;
            SELNOISE = 1;
        }
        
        if (MENUCOORD[bottom_menu] == bottom_menu_erase)
        {
            MENUCOORD[5] = 0;
            ONEBUFFER = 1;
            TWOBUFFER = 1;
            MENU_NO = 5;
            SELNOISE = 1;
        }*/
        
        if (MENUCOORD[bottom_menu] == bottom_menu_chselect)
        {
            input_enabled = false;
            SELNOISE = 1;
            snd_free_all();
            alarm[0] = 30;
        }
        
        if (MENUCOORD[bottom_menu] == bottom_menu_lang)
        {
            scr_change_language();
            scr_bettersaves_lang_change(true);
            scr_84_load_ini();
            ONEBUFFER = 2;
            TWOBUFFER = 2;
            SELNOISE = 1;
        }
        
        if (MENUCOORD[bottom_menu] == bottom_menu_quit)
        {
            ONEBUFFER = 2;
            TWOBUFFER = 2;
            SELNOISE = 1;
            game_end();
        }
    }

    if (down_p() && ONEBUFFER < 0 && TWOBUFFER < 0)
    {
        MOVENOISE = true
        MENU_NO = 0
        MENUCOORD[MENU_NO] -= 1
    }
    else
    {
        if (button2_p() && ONEBUFFER < 0 && TWOBUFFER < 0)
        {
            MENU_NO = 0
            BACKNOISE = true
            ONEBUFFER = 1
            TWOBUFFER = 1
        }
    }
}

if (MENU_NO == 0)
{
    var memloc = MENUCOORD[0];
    
    if (down_p())
    {
        if (MENUCOORD[0] < get_file_amt())
        {
            MENUCOORD[0] += 1;
            MOVENOISE = 1;
        }
    }
    
    if (up_p())
    {
        if (MENUCOORD[0] > 0)
        {
            MENUCOORD[0] -= 1;
            MOVENOISE = 1;
        }
        else
        {
            MENU_NO = bottom_menu
            MENUCOORD[MENU_NO] = bottom_menu_chselect
            MOVENOISE = true
            ONEBUFFER = 1
            TWOBUFFER = 1
        }
    }
    
    if (global.is_console)
    {
        if (MENUCOORD[0] == 7)
        {
            MENUCOORD[0] = memloc;
            MOVENOISE = false;
        }
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        MENUCOORD[1] = 0;
        MESSAGETIMER = -1;
        ONEBUFFER = 1;
        TWOBUFFER = 1;
        MENU_NO = 1;
        SELNOISE = 1;
    }

    if (button2_p() && TWOBUFFER < 0)
    {
        MENU_NO = bottom_menu
        MENUCOORD[MENU_NO] = bottom_menu_chselect
        BACKNOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
    }
}

if (OBMADE == 1)
{
    OB_DEPTH += 1;
    obacktimer += OBM;
    
    if (obacktimer >= 20)
    {
        DV = instance_create(0, 0, DEVICE_OBACK_4);
        DV.depth = 5 + OB_DEPTH;
        DV.OBSPEED = 0.01 * OBM;
        
        if (OB_DEPTH >= 60000)
            OB_DEPTH = 0;
        
        obacktimer = 0;
    }
}

if (MOVENOISE == 1)
{
    snd_play(snd_menumove);
    MOVENOISE = 0;
}

if (SELNOISE == 1)
{
    snd_play(snd_select);
    SELNOISE = 0;
}

if (BACKNOISE == 1)
{
    snd_play(snd_swing);
    BACKNOISE = 0;
}

if (DEATHNOISE == 1)
{
    snd_play(AUDIO_APPEARANCE);
    DEATHNOISE = 0;
}

ONEBUFFER -= 1;
TWOBUFFER -= 1;

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_29 = 29
}
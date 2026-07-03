if (scr_debug())
{
    if (keyboard_check_pressed(ord("R")))
        room_restart();
}

if (!input_enabled)
    exit;

if (MENU_NO == 1 || MENU_NO == 4 || MENU_NO == 6 || MENU_NO == 7 || MENU_NO == 11)
{
    var sel_type = 0
    var new_file = false
    if (MENU_NO == 1 && MENUCOORD[0] == ds_list_size(savefiles))
        new_file = true
    else
        sel_type = MENU_NO == 1 && cur_file(MENUCOORD[0], false).exists
    if MENU_NO == 11
        sel_type = false;
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
            if (MENU_NO == 1 || MENU_NO == 11)
            {
                var FILECHECK = 0;
                var FILESLOT = 0;
                var DONAMING = 0;

                if (MENU_NO == 1)
                    FILESLOT = MENUCOORD[0];
                
                if (MENU_NO == 11)
                    FILESLOT = MENUCOORD[10];

                var file = -1
                
                if MENU_NO != 11
                    file = cur_file(FILESLOT)
                else if (INCOMPLETE_LOAD)
                    file = cur_file(FILESLOT, -1, savefiles_prev)
                else
                    file = cur_file(FILESLOT, -1, savefiles_completion_prev)
                
                if !new_file
                {
                    if (MENU_NO == 1 && file.exists)
                        FILECHECK = 1;
                    
                    if (MENU_NO == 11)
                        FILECHECK = file.exists
                }

                var new_file_slot = FILESLOT
                if MENU_NO == 11
                {
                    if !file.is_first_three
                        new_file_slot = get_file_amt()
                }
                
                if (FILECHECK)
                {
                    global.filechoice = new_file_slot;
                    snd_free_all();
                    f = instance_create(0, 0, obj_persistentfadein);
                    f.image_xscale = 1000;
                    f.image_yscale = 1000;
                    
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
                        
                        if (!global.is_console)
                        {
                            ini_close();
                        }
                        else
                        {
                            readval = ini_read_real("SHOULDERLB_REASSIGN", "SHOULDERLB_REASSIGN", obj_gamecontroller.gamepad_shoulderlb_reassign);
                            
                            if (readval != -1)
                                obj_gamecontroller.gamepad_shoulderlb_reassign = readval;
                            
                            global.button0 = global.input_g[4];
                            global.button1 = global.input_g[5];
                            global.button2 = global.input_g[6];
                            global.screen_border_id = ini_read_string("BORDER", "TYPE", "Dynamic");
                            var _disable_border = global.screen_border_id == "None" || global.screen_border_id == "なし";
                            scr_enable_screen_border(!_disable_border);
                            ossafe_ini_close();
                            ossafe_savedata_save();
                        }
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
                    
                    if (MENU_NO == 1)
                    {
                        if (os_type == os_ps5)
                        {
                            with (obj_event_manager)
                                trigger_event(UnknownEnum.Value_2, UnknownEnum.Value_0);
                        }
                        scr_load();
                        exit;
                    }
                    
                    if (MENU_NO == 11)
                    {
                        var fuckass = file
                        global.filechoice = fuckass.true_file_index
                        if (INCOMPLETE_LOAD == 0)
                            scr_bettersaves_load_prev(global.bettersaves_save_types.completion)
                        else
                            scr_bettersaves_load_prev()
                        global.filechoice = new_file_slot
                        
                        if (os_type == os_ps5)
                        {
                            with (obj_event_manager)
                                trigger_event(UnknownEnum.Value_2, UnknownEnum.Value_0);
                        }
                        
                        if (global.flag[914] == 0)
                            global.flag[914] = global.chapter - 1;
                        
                        FILECHECK = -2;
                        STARTGAME = 1;
                    }
                }
                
                if (FILECHECK == 0)
                {
                    if (os_type == os_ps5)
                    {
                        with (obj_event_manager)
                            trigger_event(UnknownEnum.Value_2, UnknownEnum.Value_0);
                    }
                    
                    global.filechoice = new_file_slot;
                    var namer = instance_create(0, 0, DEVICE_NAMER);
                    namer.REMMENU = MENU_NO;
                    REMMENU = MENU_NO;
                    MENU_NO = -1;
                }
                
                if (FILECHECK == -1)
                    snd_play(snd_error);
            }
            
            if (MENU_NO == 4)
            {
                var temp_comment_is_interesting = false;
                
                if (TYPE == 0)
                {
                    TEMPCOMMENT = stringsetloc("IT CONFORMED TO THE REFLECTION.", "DEVICE_MENU_slash_Step_0_gml_74_0");
                    
                    if (NAME[0] == NAME[1] && NAME[1] == NAME[2])
                    {
                        if (TIME[0] == TIME[1] && TIME[1] == TIME[2])
                        {
                            if (PLACE[0] == PLACE[1] && PLACE[1] == PLACE[2])
                            {
                                temp_comment_is_interesting = true;
                                TEMPCOMMENT = stringsetloc("WHAT AN INTERESTING BEHAVIOR.", "DEVICE_MENU_slash_Step_0_gml_77_0");
                            }
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
                            if (PLACE[0] == PLACE[1] && PLACE[1] == PLACE[2] && !temp_comment_is_interesting)
                                TEMPCOMMENT = stringsetloc("PREPARATIONS ARE COMPLETE.", "DEVICE_MENU_slash_Step_0_gml_86_0");
                        }
                    }
                }
                
                if (TYPE == 1)
                    TEMPCOMMENT = stringsetloc("Copy complete.", "DEVICE_MENU_slash_Step_0_gml_91_0");
                
                MESSAGETIMER = 90;
                SELNOISE = 0;
                DEATHNOISE = 1;
                MENU_NO = 0;
            }

            if (MENU_NO == 6 || MENU_NO == 7)
            {
                MENU_NO = 1
                if (TYPE == 0)
                {
                    TEMPCOMMENT = stringsetloc("THEN IT WAS SPARED.", "DEVICE_MENU_slash_Step_0_gml_156_0");
                    
                    if (THREAT >= 10)
                    {
                        TEMPCOMMENT = stringsetloc("VERY INTERESTING.", "DEVICE_MENU_slash_Step_0_gml_159_0");
                        THREAT = 0;
                    }
                    
                    MESSAGETIMER = 90;
                }
            }
            
        }
        else if (MENUCOORD[MENU_NO] == 1)
        {
            if (MENU_NO == 4)
            {
                if TYPE == 0
                {
                    TEMPCOMMENT = stringsetloc("IT RETAINED ITS ORIGINAL SHAPE.", "DEVICE_MENU_slash_Step_0_gml_149_0");
                    MESSAGETIMER = 90;
                }
                MENU_NO = 3
            }
            

            if (MENU_NO == 7)
            {

                var file = cur_file(MENUCOORD[5], false)
                var push = scr_bettersaves_file_delete(file, savefiles)

                if (push && MENUCOORD[0] == get_file_amt())
                    MENUCOORD[0] -= 1
                
                TEMPCOMMENT = stringsetloc("IT WAS AS IF IT WAS NEVER THERE AT ALL.", "DEVICE_MENU_slash_Step_0_gml_126_0");
                
                if (TYPE == 1)
                    TEMPCOMMENT = stringsetloc("Erase complete.", "DEVICE_MENU_slash_Step_0_gml_127_0");
                
                MESSAGETIMER = 90;
                SELNOISE = 0;
                DEATHNOISE = 1;
                MENU_NO = 0;
                
                with (obj_event_manager)
                    trigger_event(UnknownEnum.Value_0, UnknownEnum.Value_29);
            }

            if (MENU_NO == 6)
            {
                THREAT += 1;
                MENU_NO = 7;
                MENUCOORD[7] = 0;
            }

            if MENU_NO == 1 || MENU_NO == 11
            {
                if !sel_type 
                {
                    if (MENU_NO == 11)
                        MENU_NO = 10;
                    else
                        MENU_NO = 0;
                }
                else
                {
                    MENUCOORD[2] = MENUCOORD[MENU_NO - 1]
                    MENUCOORD[3] = MENUCOORD[MENU_NO - 1]
                    MENU_NO = 3
                }
            }
        }
        else if (MENUCOORD[MENU_NO] == 2)
        {
            if (sel_type)
            {
                MENUCOORD[5] = MENUCOORD[MENU_NO - 1]
                MENU_NO = 7
                THREAT += 1;
                MENUCOORD[7] = 1
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
        
        if (MENU_NO != 0)
            BACKNOISE = 1;
        
        if (MENU_NO == 1)
            MENU_NO = 0;
        else if (MENU_NO == 4)
            MENU_NO = 3;
        else if (MENU_NO == 6)
            MENU_NO = 1;
        else if (MENU_NO == 7)
            MENU_NO = 1;
        else if (MENU_NO == 11)
            MENU_NO = 10;
    }
}

if MENU_NO == bottom_menu_copy_ver || MENU_NO == bottom_menu_prevchapter_ver
{
    var main = 3
    var back = 0
    var back_pos = 0
    var set_text = ""
    if MENU_NO == bottom_menu_prevchapter_ver
    {
        main = 10
        back = bottom_menu
        back_pos = bottom_menu_prevchapter
        set_text = stringsetloc("Please select a file.", "DEVICE_MENU_slash_Draw_0_gml_223_0");
    }
    if down_p()
    {
        MOVENOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = main
        MENUCOORD[MENU_NO] = -1
    }

    if button1_p()
    {
        SELNOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = back
        MENUCOORD[MENU_NO] = back_pos
        if set_text != ""
            TEMPCOMMENT = set_text
    }

    if button2_p()
    {
        BACKNOISE = true
        ONEBUFFER = 1
        TWOBUFFER = 1
        MENU_NO = back
        MENUCOORD[MENU_NO] = back_pos
        if set_text != ""
            TEMPCOMMENT = set_text
    }
}

if (MENU_NO == 2 || MENU_NO == 3 || MENU_NO == 5)
{
    if (down_p())
    {
        if (MENUCOORD[MENU_NO] < get_file_amt())
        {
            MENUCOORD[MENU_NO] += 1;
            MOVENOISE = 1;
        }
    }
    
    if (up_p())
    {
        if (MENUCOORD[MENU_NO] > 0)
        {
            MENUCOORD[MENU_NO] -= 1;
            MOVENOISE = 1;
        }
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        var file = cur_file(MENUCOORD[MENU_NO])
        if (MENU_NO == 3)
        {
            if (MENUCOORD[2] != MENUCOORD[3])
            {
                if MENUCOORD[MENU_NO] == get_file_amt()
                {
                    TEMPCOMMENT = stringsetloc("THE DIVISION IS COMPLETE.", "DEVICE_MENU_slash_Step_0_gml_225_0");
                    MESSAGETIMER = 90;
                    
                    if (TYPE == 1)
                        TEMPCOMMENT = stringsetloc("Copy complete.", "DEVICE_MENU_slash_Step_0_gml_227_0");
                    
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
                else if (file.exists)
                {
                    TWOBUFFER = 2;
                    ONEBUFFER = 2;
                    SELNOISE = 1;
                    MENUCOORD[4] = 0;
                    MENU_NO = 4;
                }
                else
                {
                    TEMPCOMMENT = stringsetloc("THE DIVISION IS COMPLETE.", "DEVICE_MENU_slash_Step_0_gml_225_0");
                    MESSAGETIMER = 90;
                    
                    if (TYPE == 1)
                        TEMPCOMMENT = stringsetloc("Copy complete.", "DEVICE_MENU_slash_Step_0_gml_227_0");
                    
                    DEATHNOISE = 1;
                    MENU_NO = 0;
                    ONEBUFFER = 2;
                    TWOBUFFER = 2;
                    event_user(5);
                }
            }
            else
            {
                TEMPCOMMENT = stringsetloc("IT IS IMMUNE TO ITS OWN IMAGE.", "DEVICE_MENU_slash_Step_0_gml_238_0");
                
                if (TYPE == 1)
                    TEMPCOMMENT = stringsetloc("You can't copy there.", "DEVICE_MENU_slash_Step_0_gml_239_0");
                
                MESSAGETIMER = 90;
                TWOBUFFER = 2;
                ONEBUFFER = 2;
                BACKNOISE = 1;
            }
        }
        
        if (MENU_NO == 2)
        {
            if (FILE[MENUCOORD[MENU_NO]] == 1)
            {
                TWOBUFFER = 2;
                ONEBUFFER = 2;
                SELNOISE = 1;
                MENUCOORD[3] = 0;
                MENU_NO = 3;
            }
            else
            {
                TEMPCOMMENT = stringsetloc("IT IS BARREN AND CANNOT BE COPIED.", "DEVICE_MENU_slash_Step_0_gml_261_0");
                
                if (FILE[0] == 0 && FILE[1] == 0 && FILE[2] == 0)
                    TEMPCOMMENT = stringsetloc("BUT THERE WAS NOTHING LEFT TO COPY.", "DEVICE_MENU_slash_Step_0_gml_264_0");
                
                if (TYPE == 1)
                    TEMPCOMMENT = stringsetloc("It can't be copied.", "DEVICE_MENU_slash_Step_0_gml_266_0");
                
                MESSAGETIMER = 90;
                BACKNOISE = 1;
                TWOBUFFER = 2;
                ONEBUFFER = 2;
            }
        }
        
        if (MENU_NO == 5)
        {
            if (FILE[MENUCOORD[MENU_NO]] == 1)
            {
                TWOBUFFER = 2;
                ONEBUFFER = 2;
                SELNOISE = 1;
                MENUCOORD[6] = 0;
                MENU_NO = 6;
            }
            else
            {
                TEMPCOMMENT = stringsetloc("BUT IT WAS ALREADY GONE.", "DEVICE_MENU_slash_Step_0_gml_289_0");
                
                if (FILE[0] == 0 && FILE[1] == 0 && FILE[2] == 0)
                    TEMPCOMMENT = stringsetloc("BUT THERE WAS NOTHING LEFT TO ERASE.", "DEVICE_MENU_slash_Step_0_gml_292_0");
                
                if (TYPE == 1)
                    TEMPCOMMENT = stringsetloc("There's nothing to erase.", "DEVICE_MENU_slash_Step_0_gml_294_0");
                
                MESSAGETIMER = 90;
                TWOBUFFER = 2;
                ONEBUFFER = 2;
                BACKNOISE = 1;
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

if (MENU_NO == 10)
{
    var M = MENU_NO;
    var MAXY = 3;
    
    if (down_p())
    {
        if (MENUCOORD[MENU_NO] < (ds_list_size(savefiles_completion_prev) - 1))
        {
            MENUCOORD[MENU_NO] += 1;
            MOVENOISE = 1;
        }
    }
    
    if (up_p())
    {
        if (MENUCOORD[MENU_NO] > 0)
        {
            MENUCOORD[MENU_NO] -= 1;
            MOVENOISE = 1;
        }
        else
        {
            MOVENOISE = 1;
            MENU_NO = bottom_menu_prevchapter_ver
            ONEBUFFER = 1
            TWOBUFFER = 1
        }
    }
    
    if (button1_p() && ONEBUFFER < 0)
    {
        MESSAGETIMER = -1;
        var file = -1
        if INCOMPLETE_LOAD
            file = cur_file(MENUCOORD[MENU_NO], -1, savefiles_prev)
        else
            file = cur_file(MENUCOORD[MENU_NO], -1, savefiles_completion_prev)

        FILECHECK = file.exists;
        
        if (FILECHECK)
        {
            MENUCOORD[M + 1] = 0;
            ONEBUFFER = 1;
            TWOBUFFER = 1;
            MENU_NO = M + 1;
            SELNOISE = 1;
        }
        else
        {
            ONEBUFFER = 4;
            snd_play(snd_error);
        }
}
    
    if (button2_p() && TWOBUFFER < 0)
    {
        TWOBUFFER = 2;
        ONEBUFFER = 2;
        BACKNOISE = 1;
        MENU_NO = bottom_menu;
        MENUCOORD[MENU_NO] = bottom_menu_prevchapter
        TEMPCOMMENT = stringsetloc("Please select a file.", "DEVICE_MENU_slash_Draw_0_gml_223_0");
    }
}

if (MENU_NO == bottom_menu)
{
    var max_r = bottom_menu_quit
    if (!CANQUIT)
        max_r -= 1
    
    if (right_p())
    {
        if (MENUCOORD[bottom_menu] >= bottom_menu_chselect && MENUCOORD[bottom_menu] < max_r)
        {
            MOVENOISE = true;
            MENUCOORD[bottom_menu] += 1;
        }
        else if (MENUCOORD[bottom_menu] == max_r)
        {
            MOVENOISE = true;
            MENUCOORD[bottom_menu] = bottom_menu_chselect;
        }
    }
    
    if (left_p())
    {
        if (MENUCOORD[bottom_menu] >= bottom_menu_chselect && MENUCOORD[bottom_menu] <= max_r)
        {
            MOVENOISE = true;
            MENUCOORD[bottom_menu] -= 1;
            
            if (MENUCOORD[bottom_menu] < bottom_menu_chselect)
                MENUCOORD[bottom_menu] = max_r;
        }
    }

    if up_p()
    {
        if MENUCOORD[bottom_menu] >= bottom_menu_prevchapter
        {
            MOVENOISE = 1;
            MENUCOORD[bottom_menu] = bottom_menu_chselect;
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
            scr_bettersaves_lang_change(true)
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

        if MENUCOORD[bottom_menu] == bottom_menu_prevchapter
        {
            ONEBUFFER = 2
            TWOBUFFER = 2
            SELNOISE = true
            MENU_NO = 10
            MENUCOORD[MENU_NO] = 0
        }
    }

    if (down_p() && ONEBUFFER < 0 && TWOBUFFER < 0)
    {
        if MENUCOORD[bottom_menu] < bottom_menu_prevchapter
        {
            MOVENOISE = true;
            MENUCOORD[bottom_menu] = bottom_menu_prevchapter;
        }
        else
        {
            MOVENOISE = true;
            MENU_NO = 0
            MENUCOORD[MENU_NO] = -1
            ONEBUFFER = 1
            TWOBUFFER = 1
        }
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
    var M = MENU_NO;
    
    if (down_p())
    {
        if MENUCOORD[0] < ds_list_size(savefiles)
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
    
    if (button1_p() && ONEBUFFER < 0)
    {
        file = -1
        var FILECHECK = 1
        if MENU_NO == 10
        {
            if INCOMPLETE_LOAD
                file = cur_file(MENUCOORD[M], -1, savefiles_prev)
            else
                file = cur_file(MENUCOORD[M], -1, savefiles_completion_prev)
            FILECHECK = file.exists;
        }

        MESSAGETIMER = -1;
        
        if (FILECHECK)
        {
            MENU_NO += 1;
            MENUCOORD[MENU_NO] = 0;
            ONEBUFFER = 1;
            TWOBUFFER = 1;
            SELNOISE = 1;
        }
        else
        {
            ONEBUFFER = 4;
            snd_play(snd_error);
        }
    }
    
    if (button2_p() && TWOBUFFER < 0)
    {
        ONEBUFFER = 1;
        TWOBUFFER = 1;
        BACKNOISE = 1;

        if (MENU_NO == 0)
        {
            MENU_NO = bottom_menu
            MENUCOORD[MENU_NO] = bottom_menu_chselect
        }
            
        
        if (MENU_NO == 10)
            MENU_NO = 0;
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

if (STARTGAME == 1)
    scr_bettersaves_chapter_start()

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_29 = 29
}

if (global.is_console)
{
    if (global.savedata_async_id >= 0)
        exit;
    
    if (!variable_global_exists("chapter"))
        exit;
    
    if (!textures_loaded)
        textures_loaded = loadtex.loaded;
    
    if (textures_loaded)
    {
    }
    else
    {
        exit;
    }
}

var CH = string(global.chapter);

if (audio_group_is_loaded(1))
{
    roomchoice = PLACE_CONTACT;
    menu_go = 0;
    
    if (scr_bettersaves_any_saves_simple(global.chapter, 1))
        menu_go = 2;
    
    if (global.is_console)
    {
        if (global.game_won == 1)
            menu_go = 2;
    }
    
    if (menu_go == 0 || menu_go == 1)
    {
        if (global.is_console)
            global.screen_border_alpha = 0;
        
        roomchoice = room_intro_ch2;
    }
    
    if (menu_go == 2)
    {
        if (global.is_console)
            global.screen_border_alpha = 1;
        
        scr_windowcaption("DELTARUNE");
        global.tempflag[10] = 1;
        roomchoice = room_legend;
        global.plot = 0;
    }
    
    if (menu_go == 3)
    {
        if (global.is_console)
            global.screen_border_alpha = 0;
        
        roomchoice = room_next(room);
    }
    
    room_goto(roomchoice);
}

if (scr_debug())
{
}

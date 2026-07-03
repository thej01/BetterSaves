TYPE = 1;
SUBTYPE = 0;
scr_bettersaves_local_funcs()
scr_bettersaves_get_all_saves(-1, 0)
savefiles = savefiles_normal
scr_bettersaves_get_all_saves(global.chapter - 1, true)
savefiles_completion_prev = savefiles_completion
scr_bettersaves_get_all_saves(global.chapter - 1, false)
savefiles_prev = savefiles_normal
CH = string(global.chapter);

if scr_bettersaves_any_completion()
    SUBTYPE = 1
    
INCOMPLETE_LOAD = 0;

if (TYPE == 0)
{
    scr_windowcaption(stringsetloc("CONTACT", "DEVICE_MENU_slash_Create_0_gml_8_0"));
    global.currentsong[0] = snd_init("AUDIO_DRONE.ogg");
    global.currentsong[1] = mus_loop(global.currentsong[0]);
}

if (TYPE == 1)
{
    instance_create(0, 0, obj_fadein);
    global.tempflag[10] = 1;
    scr_windowcaption(stringsetloc("DELTARUNE", "DEVICE_MENU_slash_Create_0_gml_17_0"));
    
    if (SUBTYPE == 0)
        global.currentsong[0] = snd_init("menu.ogg");
    
    if (SUBTYPE == 1)
        global.currentsong[0] = snd_init("AUDIO_STORY.ogg");
    
    if (SUBTYPE >= 1)
        scr_enable_chapter_skip(global.chapter)
    
    global.currentsong[1] = mus_loop_ext(global.currentsong[0], 1, 0.95);
}

BGMADE = 0;
BG_ALPHA = 0;
BG_SINER = 0;
OBMADE = 0;
OB_DEPTH = 0;
obacktimer = 0;
OBM = 0.5;
COL_A = c_green;
COL_B = c_lime;
COL_PLUS = merge_color(c_lime, c_white, 0.5);
jamod = 0;

if (TYPE == 1)
{
    BGSINER = 0;
    BGMAGNITUDE = 6;
    COL_A = merge_color(c_ltgray, c_navy, 0.2);
    COL_B = c_white;
    COL_PLUS = merge_color(c_yellow, c_white, 0.5);
    BGMADE = 1;
    BG_ALPHA = 0;
    ANIM_SINER = 0;
    ANIM_SINER_B = 0;
    TRUE_ANIM_SINER = 0;
    
    if (SUBTYPE == 0)
    {
        COL_A = merge_color(c_ltgray, c_maroon, 0.2);
        COL_B = c_white;
        COL_PLUS = merge_color(c_yellow, c_white, 0.4);
        BGMADE = 0;
    }
}

MENU_NO = 0;

for (i = 0; i < 12; i += 1)
    MENUCOORD[i] = 0;

XL = 210;
YL = 40;
YS = 5;
HEARTX = 75;
HEARTY = 110;
HEARTXCUR = 75;
HEARTYCUR = 75;
MOVENOISE = 0;
SELNOISE = 0;
BACKNOISE = 0;
DEATHNOISE = 0;
STARTGAME = 0;
REMMENU = 0;
CANQUIT = 1;

if (global.is_console == 1)
    CANQUIT = 0;

ONEBUFFER = 2;
TWOBUFFER = 0;
THREAT = 0;
TEMPMESSAGE = " ";
MESSAGETIMER = 0;
version_text = "1.00";

if (scr_is_switch_os())
    version_text = "1.03";

if (os_type == os_ps4 || os_type == os_ps5)
    version_text = "1.00";

/*for (i = 0; i < 3; i += 1)
    FILE[i] = 0;

for (i = 0; i < 3; i += 1)
{
    FILE[i] = 0;
    NAME[i] = stringsetloc("[EMPTY]", "DEVICE_MENU_slash_Create_0_gml_97_0");
    TIME[i] = 0;
    PLACE[i] = "------------";
    LEVEL[i] = 0;
    TIME_STRING[i] = "--:--";
    INITLANG[i] = 0;
}

if (ossafe_file_exists("filech" + CH + "_0"))
{
    FILE[0] = 1;
    NAME[0] = "FILE0";
}

if (ossafe_file_exists("filech" + CH + "_1"))
{
    FILE[1] = 1;
    NAME[1] = "FILE1";
}

if (ossafe_file_exists("filech" + CH + "_2"))
{
    FILE[2] = 1;
    NAME[2] = "FILE2";
}

if (ossafe_file_exists("dr.ini"))
{
    ossafe_ini_open("dr.ini");
    
    for (i = 0; i < 3; i += 1)
    {
        if (FILE[i] == 1)
        {
            var room_id = ini_read_real(scr_ini_chapter(global.chapter, i), "Room", scr_get_id_by_room_index(room));
            var room_index = scr_get_valid_room(global.chapter, room_id);
            PLACE[i] = scr_roomname(room_index);
            TIME[i] = ini_read_real(scr_ini_chapter(global.chapter, i), "Time", 0);
            NAME[i] = ini_read_string(scr_ini_chapter(global.chapter, i), "Name", "------");
            LEVEL[i] = 1;
            INITLANG[i] = ini_read_real(scr_ini_chapter(global.chapter, i), "InitLang", 0);
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
    
    var cadd = 3;
    
    if (INCOMPLETE_LOAD)
        cadd = 0;
    
    for (i = 0; i < 3; i++)
    {
        COMPLETEFILE_PREV_NAME[i] = stringsetloc("NO DATA", "DEVICE_MENU_slash_Create_0_gml_182_0");
        COMPLETEFILE_PREV_TIME[i] = 0;
        COMPLETEFILE_PREV_PLACE[i] = stringsetloc("CHAPTER 1", "DEVICE_MENU_slash_Create_0_gml_221_0");
        INCOMPLETEFILE_PREV_NAME[i] = stringsetloc("NO DATA", "DEVICE_MENU_slash_Create_0_gml_185_0");
        INCOMPLETEFILE_PREV_TIME[i] = 0;
        var loadcompletion = 0;
        
        if (COMPLETEFILE_PREV[i] == 1 && INCOMPLETE_LOAD == 0)
            loadcompletion = 1;
        
        if (INCOMPLETEFILE_PREV[i] == 1 && INCOMPLETE_LOAD == 1)
            loadcompletion = 1;
        
        if (loadcompletion)
        {
            COMPLETEFILE_PREV_NAME[i] = stringsetloc("UNKNOWN FILE", "DEVICE_MENU_slash_Create_0_gml_190_0");
            COMPLETEFILE_PREV_NAME[i] = ini_read_string(scr_ini_chapter(global.chapter - 1, i + cadd), "Name", "------");
            COMPLETEFILE_PREV_TIME[i] = ini_read_real(scr_ini_chapter(global.chapter - 1, i + cadd), "Time", 0);
            COMPLETEFILE_PREV_PLACE[i] = stringsetloc("CHAPTER 1", "DEVICE_MENU_slash_Create_0_gml_237_0");
            COMPLETETIME_SECONDS_TOTAL[i] = floor(COMPLETEFILE_PREV_TIME[i] / 30);
            COMPLETETIME_MINUTES[i] = floor(COMPLETETIME_SECONDS_TOTAL[i] / 60);
            COMPLETETIME_SECONDS[i] = COMPLETETIME_SECONDS_TOTAL[i] - (COMPLETETIME_MINUTES[i] * 60);
            COMPLETETIME_SECONDS_STRING[i] = string(COMPLETETIME_SECONDS[i]);
            
            if (COMPLETETIME_SECONDS[i] == 0)
                COMPLETETIME_SECONDS_STRING[i] = "00";
            
            if (COMPLETETIME_SECONDS[i] < 10 && COMPLETETIME_SECONDS[i] >= 1)
                COMPLETETIME_SECONDS_STRING[i] = "0" + string(COMPLETETIME_SECONDS[i]);
            
            COMPLETETIME_STRING[i] = scr_timedisp(COMPLETEFILE_PREV_TIME[i]);
        }
        
        if (INCOMPLETEFILE_PREV[i])
        {
            INCOMPLETEFILE_PREV_NAME[i] = stringsetloc("UNKNOWN FILE", "DEVICE_MENU_slash_Create_0_gml_205_0");
            INCOMPLETEFILE_PREV_NAME[i] = ini_read_string(scr_ini_chapter(global.chapter - 1, i), "Name", "------");
            INCOMPLETEFILE_PREV_TIME[i] = ini_read_real(scr_ini_chapter(global.chapter - 1, i), "Time", 0);
        }
    }
    
    ossafe_ini_close();
    ossafe_savedata_save();
}*/

var INITMENU = 0;

if (ossafe_file_exists(scr_bettersaves_get_drini()))
{
    if !scr_bettersaves_any_incomplete()
    {
        if (scr_bettersaves_any_completion(savefiles_prev))
            INITMENU = 10;
        
        if (INCOMPLETE_LOAD == 1)
            INITMENU = 10;
    }
}

MENU_NO = INITMENU;
depth = 5;
jamod = 0;
input_enabled = true;

bottom_menu = array_length(MENUCOORD)
MENUCOORD[bottom_menu] = 0
bottom_menu_copy_ver = bottom_menu + 1
MENUCOORD[bottom_menu_copy_ver] = 0
bottom_menu_prevchapter_ver = bottom_menu_copy_ver + 1
MENUCOORD[bottom_menu_prevchapter_ver] = 0

bottom_menu_copy = 3
bottom_menu_erase = 4
bottom_menu_chselect = 5
bottom_menu_lang = 6
bottom_menu_quit = 7
bottom_menu_prevchapter = 8

scroll_y = 0
scroll_speed = 4
box_surf = -1
text_surf = -1

bottom_menu_alpha = 1
bottom_menu_fade = false
message_alpha = 1
message_fade = false

text_fade_speed = 0.1
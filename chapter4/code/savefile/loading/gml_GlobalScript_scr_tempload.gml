function scr_tempload()
{
    filechoicebk3 = global.filechoice;
    global.filechoice = 9;
    scr_load(global.bettersaves_save_types.temp);
    global.filechoice = filechoicebk3;
}

function scr_tempsave()
{
    filechoicebk2 = global.filechoice;
    global.filechoice = 9;
    scr_saveprocess(global.filechoice, global.bettersaves_save_types.temp);
    global.filechoice = filechoicebk2;
}

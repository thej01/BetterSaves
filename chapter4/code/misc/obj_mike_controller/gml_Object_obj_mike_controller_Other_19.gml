if (ossafe_file_exists(scr_bettersaves_get_drini()))
{
    ini_ex = 1;
    iniread = ossafe_ini_open(scr_bettersaves_get_drini());
    var file = scr_bettersaves_file_struct(global.filechoice);
    var ini = scr_bettersaves_ini_from_struct(file);
    global.microphone = ini_read_real(ini, "Microphone", 0);
    global.right_click_mic = ini_read_real(ini, "right_click_mic", 0);
    global.mic_sensitivity = ini_read_real(ini, "Mic Sensitivity", 0.5);
    ossafe_ini_close();
    ossafe_savedata_save();
}

ossafe_ini_open(scr_bettersaves_get_drini());
var file = scr_bettersaves_file_struct(global.filechoice);
var ini = scr_bettersaves_ini_from_struct(file);
ini_write_real(ini, "Microphone", global.microphone);
ini_write_real(ini, "right_click_mic", global.right_click_mic);
ini_write_real(ini, "Mic Sensitivity", global.mic_sensitivity);
ossafe_ini_close();
ossafe_savedata_save();

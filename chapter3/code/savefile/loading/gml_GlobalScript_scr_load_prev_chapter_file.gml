function scr_load_prev_chapter_file(arg0 = 0, type = global.bettersaves_save_types.completion)
{
    var _chapter = arg0;
    
    switch (_chapter)
    {
        case 1:
            scr_load_chapter1(type);
            break;
        
        case 2:
            scr_load_chapter2(type);
            break;
        
        default:
            break;
    }
}

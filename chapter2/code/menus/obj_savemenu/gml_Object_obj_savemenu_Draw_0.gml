xx = __view_get(e__VW.XView, 0);
yy = __view_get(e__VW.YView, 0);

if (saved == 0)
    time_current = global.time;

scr_84_set_draw_font("main");

if (d == 2)
    scr_84_set_draw_font("mainbig");

if (menuno == 0)
{
    if (d == 1)
    {
        draw_set_color(c_white);
        draw_rectangle(50 + xx, 49 + yy, 269 + xx, 135 + yy, false);
        draw_set_color(c_black);
        draw_rectangle((53 * d) + xx, (52 * d) + yy, (266 * d) + xx, (132 * d) + yy, false);
    }
    else
    {
        scr_darkbox(((54 * d) + xx) - 16, (49 * d) + yy, (265 * d) + xx + 16, (135 * d) + yy + (type * 45));
        draw_set_color(c_black);
        draw_rectangle(((64 * d) + xx) - 16, (59 * d) + yy, (255 * d) + xx + 16, (125 * d) + yy + (type * 45), false);
    }
    
    draw_set_color(c_white);
    
    if (xcoord == 2)
        draw_set_color(c_yellow);
    
    draw_set_halign(fa_left);
    
    if (!scr_kana_check(name_current))
    {
        draw_text((60 * d) + xx, (60 * d) + yy, string_hash_to_newline(name_current));
    }
    else
    {
        draw_set_font(fnt_ja_mainbig);
        draw_text((60 * d) + xx, (60 * d) + yy, string_hash_to_newline(name_current));
        
        if (global.lang != "ja")
            draw_set_font(fnt_mainbig);
    }
    
    draw_set_halign(fa_right);
    draw_text((200 * d) + xx, (60 * d) + yy, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
    draw_text((261 * d) + xx, (60 * d) + yy, scr_timedisp(time_current));
    draw_set_halign(fa_center);
    draw_text_width((160 * d) + xx, (85 * d) + yy, string_hash_to_newline(scr_roomname(room)), 360);
    draw_set_halign(fa_left);
    
    if (xcoord < 2)
        draw_sprite(heartsprite, 0, xx + (71 * d) + (xcoord * 90 * d), yy + (114 * d) + (ycoord * 42));
    
    if (xcoord < 2)
    {
        draw_text(xx + (85 * d), yy + (110 * d), string_hash_to_newline(stringsetloc("Save", "obj_savemenu_slash_Draw_0_gml_47_0")));
        draw_text(xx + (175 * d), yy + (110 * d), string_hash_to_newline(stringsetloc("Return", "obj_savemenu_slash_Draw_0_gml_48_0")));
        
        if (type == 1)
        {
            draw_text(xx + (85 * d), yy + (130 * d), stringsetloc("Storage", "obj_savemenu_slash_Draw_0_gml_52_0_b"));
            
            if (!haverecruited)
                draw_set_color(c_gray);
            
            draw_text(xx + (175 * d), yy + (130 * d), stringsetloc("Recruits", "obj_savemenu_slash_Draw_0_gml_54_0"));
        }
    }
    else
    {
        draw_text(xx + (85 * d), yy + (110 * d), string_hash_to_newline(stringsetloc("File saved.", "obj_savemenu_slash_Draw_0_gml_52_0")));
    }
}
else if menuno == 1 || menuno == 2
{

    if (overwrite == 0 || menuno == 2)
    {
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(xx - 10, yy - 10, xx + 640 + 10, yy + 480 + 10, 0);
        draw_set_alpha(1);
    }
    
    var yoff = 0;
    var wmod = 28;
    var mwidth = 520;
    var mheight = 105;
    var mx = 60;
    var my = 12 + yoff;
    scr_darkbox_black(camerax() + mx, cameray() + my, camerax() + mx + mwidth, cameray() + my + mheight);
    mwidth = 520;
    var scroll_pos = mpos
    var scroll_y = 0
    if (scroll_pos > save_count - 2)
        scroll_pos = save_count - 2
    if (scroll_pos > 1 && save_count > 3)
        scroll_y = scroll_pos - 1;
    var ext_box = 38
    var upy = -24
    mheight = 316 + ext_box;
    mx = 60;
    my = 144 + upy + yoff;
    scr_darkbox_black(camerax() + mx, cameray() + my, camerax() + mx + mwidth, cameray() + my + mheight);
    
    draw_sprite_ext(spr_textbox_top, 0, camerax() + mx + 14, cameray() + my + ext_box, mwidth * 0.948, 2, 0, c_white, 1);
    for (var i = 0; i < save_count; i++)
        draw_sprite_ext(spr_textbox_top, 0, camerax() + mx + 14, cameray() + 208 + ext_box + (84 * i) + yoff, mwidth * 0.948, 2, 0, c_white, 1);
    
    if menuno == 2
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(camerax() + 320, cameray() + 32 + yoff, global.truename);
    draw_set_halign(fa_left);
    draw_text(camerax() + mx + 40, cameray() + 32 + yoff, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
    draw_set_halign(fa_right);
    draw_text(camerax() + mx + 483, cameray() + 32 + yoff, scr_timedisp(time_current));
    draw_set_halign(fa_center);
    draw_text(camerax() + 320, cameray() + 64 + yoff, room_current);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    newfile = stringsetloc("New File", "obj_savemenu_slash_Draw_0_gml_115_0");
    var mspace = 84;

    my += ext_box
    var preview_top_y = cameray() + my - (ext_box / 2) - 5
    my -= mspace * scroll_y

    var add_file_txt = "+ " + newfile + "..."
    var next_file_x = (camerax() + 320) - string_width(add_file_txt)
    
    for (var i = 0; i < (save_count + 1); i++)
    {
        var screen_i = i - scroll_y
        if screen_i < -1 || screen_i > 3
            continue;

        var preview_type = 0 
        if screen_i == -1
            preview_type = -1
        if screen_i == 3
            preview_type = 1

        if menuno == 2
            draw_set_color(#444444)
        else
            draw_set_color(c_white);
        
        if (mpos == i)
            draw_set_color(c_yellow);

        var preview_bottom_y = cameray() + my + 16 + (i * mspace)

        if i == save_count
        {
            draw_set_halign(fa_center);
            if menuno == 2 && mpos == i
            {
                draw_set_color(c_yellow)
                draw_text(camerax() + 320, preview_bottom_y, stringsetloc("File Saved", "obj_savemenu_slash_Draw_0_gml_371_0"));
            }
            else
                draw_text(camerax() + 320, preview_bottom_y, add_file_txt);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
            continue;
        }

        var base_y = cameray() + my + 20 + (i * mspace)
        var base_x = camerax() + mx + 40 + 24
        if preview_type != 0
        {
            if menuno == 2
                draw_set_color(merge_color(c_gray, c_black, 0.74))
            else
                draw_set_color(c_gray)
        }
        if preview_type == -1
            base_y = preview_top_y 
        if preview_type == 1
            base_y = preview_bottom_y
        if menuno != 2 || (menuno == 2 && mpos != i)
        {
            if (level_file[i] != 0)
            {
                draw_set_halign(fa_left);
                draw_text(camerax() + mx + 40 + 24, base_y, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
                draw_set_halign(fa_right);
                draw_text(camerax() + mx + 483, base_y, scr_timedisp(time_file[i]));
                draw_set_halign(fa_center);
                if preview_type == 0
                    draw_text(camerax() + 320, base_y + 32, scr_roomname(roome_file[i]));
                
                if (!scr_kana_check(name_file[i]))
                {
                    draw_text(camerax() + 320, base_y, name_file[i]);
                }
                else
                {
                    draw_set_font(fnt_ja_mainbig);
                    draw_text(camerax() + 320, base_y, name_file[i]);
                    
                    if (global.lang != "ja")
                        draw_set_font(fnt_mainbig);
                }
                
                draw_set_halign(fa_left);
                draw_set_color(c_white);
            }
            else
            {
                if preview_type != 0
                    base_y -= 16
                draw_set_halign(fa_center);
                draw_text(camerax() + 320, base_y + 16, newfile);
                draw_set_halign(fa_left);
                draw_set_color(c_white);
            }
        }
        else
        {
            draw_set_color(c_yellow)
            draw_set_halign(fa_center);
            draw_text(camerax() + 320, base_y + 16, stringsetloc("File Saved", "obj_savemenu_slash_Draw_0_gml_371_0"));
            draw_set_halign(fa_left);
            draw_set_color(c_white);
        }
    }
    
    if scroll_y <= 0
    {
        draw_set_halign(fa_center);
        
        if (mpos == -1)
            draw_set_color(c_yellow);

        if menuno == 2
            draw_set_color(#444444)
        
        returntxt = stringsetloc("Return", "obj_savemenu_slash_Draw_0_gml_48_0");
        draw_text(camerax() + 320, preview_top_y, string_hash_to_newline(returntxt));
        draw_set_halign(fa_left);
        draw_set_color(c_white);
    }
    
    if (overwrite == 0 && menuno != 2)
    {
        if (mpos != -1)
        {
            if mpos == save_count
                draw_sprite(heartsprite, 0, (camerax() + 320) - (string_width(add_file_txt) / 2) - 32, (cameray() + my + (mspace * mpos) + 62) - 40 + 3);
            else
            {
                if (level_file[mpos] != 0)
                    draw_sprite(heartsprite, 0, camerax() + mx + 32, (cameray() + my + (mspace * mpos) + 62) - 34);
                else
                    draw_sprite(heartsprite, 0, (camerax() + 320) - (string_width(newfile) / 2) - 32, cameray() + my + 36 + (mpos * mspace) + (string_height(newfile) / 4));
            }
        }
        else
        {
            draw_sprite(heartsprite, 0, (camerax() + 320) - string_width(returntxt), cameray() + my - (ext_box / 2) + 4);
        }
    }
    
    if (overwrite == 1)
    {
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(xx - 10, yy - 10, xx + 640 + 10, yy + 480 + 10, 0);
        draw_set_alpha(1);
        saved = 2;
        scr_darkbox_black(camerax() + 10, cameray() + 100, (camerax() + 640) - 10, (cameray() + 480) - 100);
        overwritetext = stringsetsubloc("Overwrite Slot ~1?", mpos + 1, "obj_savemenu_slash_Draw_0_gml_215_0");
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(camerax() + 320, (((cameray() + 120) - 4) + 19) - 12, string_hash_to_newline(overwritetext));
        draw_set_color(c_yellow);
        var currentSpace = 70;
        var horzspace = 80;
        draw_set_halign(fa_left);
        draw_text(camerax() + horzspace, ((15 + cameray() + 180) - 30) + currentSpace, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
        draw_set_halign(fa_right);
        draw_text((camerax() + 640) - horzspace, ((15 + cameray() + 180) - 30) + currentSpace, scr_timedisp(time_current));
        draw_set_halign(fa_center);
        draw_text(camerax() + 320, 15 + cameray() + 180 + currentSpace, room_current);
        
        if (scr_kana_check(name_current))
            draw_set_font(fnt_ja_mainbig);
        
        draw_text(camerax() + 320, ((15 + cameray() + 180) - 30) + currentSpace, name_current);
        
        if (global.lang == "en")
            draw_set_font(fnt_mainbig);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(camerax() + horzspace, (15 + cameray() + 180) - 30, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
        draw_set_halign(fa_right);
        draw_text((camerax() + 640) - horzspace, (15 + cameray() + 180) - 30, scr_timedisp(time_file[mpos]));
        draw_set_halign(fa_center);
        draw_text(camerax() + 320, 15 + cameray() + 180, scr_roomname(roome_file[mpos]));
        
        if (scr_kana_check(name_file[mpos]))
            draw_set_font(fnt_ja_mainbig);
        
        draw_text(camerax() + 320, (15 + cameray() + 180) - 30, name_file[mpos]);
        
        if (global.lang == "en")
            draw_set_font(fnt_mainbig);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        savetxt = stringsetloc("Save", "obj_savemenu_slash_Draw_0_gml_47_0");
        returntxt = stringsetloc("Return", "obj_savemenu_slash_Draw_0_gml_48_0");
        
        if (left_p() || right_p())
            overcoord = 1 - overcoord;
        
        if (overcoord == 0)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);
        
        draw_text(xx + 170, yy + 300 + 12 + 12, string_hash_to_newline(savetxt));
        
        if (overcoord == 1)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);
        
        draw_text(xx + 350, yy + 300 + 12 + 12, string_hash_to_newline(returntxt));
        
        if (overcoord == 0)
            draw_sprite(heartsprite, 0, ((xx + 170) - 32) + 4, yy + 300 + 24 + (string_height(savetxt) / 4));
        else
            draw_sprite(heartsprite, 0, ((xx + 350) - 32) + 4, yy + 300 + 24 + (string_height(returntxt) / 4));

    }
}
/*else if (menuno == 2)
{
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(xx - 10, yy - 10, xx + 640 + 10, yy + 480 + 10, 0);
    draw_set_alpha(1);
    var yoff = 0;
    var wmod = 28;
    var mwidth = 520;
    var mheight = 105;
    var mx = 60;
    var my = 12 + yoff;
    scr_darkbox_black(camerax() + mx, cameray() + my, camerax() + mx + mwidth, cameray() + my + mheight);
    mwidth = 520;
    mheight = 273;
    mx = 60;
    my = 124 + yoff;
    scr_darkbox_black(camerax() + mx, cameray() + my, camerax() + mx + mwidth, cameray() + my + mheight);
    
    for (var i = 0; i < 2; i++)
        draw_sprite_ext(spr_textbox_top, 0, camerax() + mx + 14, cameray() + 208 + (84 * i) + yoff, mwidth * 0.948, 2, 0, c_white, 1);
    
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(camerax() + 320, cameray() + 32 + yoff, global.truename);
    draw_set_halign(fa_left);
    draw_text(camerax() + mx + 40, cameray() + 32 + yoff, string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
    draw_set_halign(fa_right);
    draw_text(camerax() + mx + 483, cameray() + 32 + yoff, scr_timedisp(time_current));
    draw_set_halign(fa_center);
    draw_text(camerax() + 320, cameray() + 64 + yoff, room_current);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    newfile = stringsetloc("New File", "obj_savemenu_slash_Draw_0_gml_115_0");
    var mspace = 84;
    
    for (var i = 0; i < (save_count + 1); i++)
    {
        draw_set_color(c_white);
        
        if (mpos == i)
            draw_set_color(c_yellow);

        if i == save_count
        {
            draw_set_halign(fa_center);
            draw_text(camerax() + 320, cameray() + my + 30 + (i * mspace), newfile);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
            continue;
        }
        
        if (mpos != i)
        {
            draw_set_color(#444444);
            
            if (level_file[i] != 0)
            {
                draw_set_halign(fa_left);
                draw_text(camerax() + mx + 40, cameray() + my + 20 + (i * mspace), string_hash_to_newline(stringsetsubloc("LV ~1", global.chapter, "obj_savemenu_slash_Draw_0_gml_34_0")));
                draw_set_halign(fa_right);
                draw_text(camerax() + mx + 483, cameray() + my + 20 + (i * mspace), scr_timedisp(time_file[i]));
                draw_set_halign(fa_center);
                draw_text(camerax() + 320, cameray() + my + 52 + (i * mspace), scr_roomname(roome_file[i]));
                
                if (scr_kana_check(name_file[i]))
                    draw_set_font(fnt_ja_mainbig);
                
                draw_text(camerax() + 320, cameray() + my + 20 + (i * mspace), name_file[i]);
                
                if (global.lang == "en")
                    draw_set_font(fnt_mainbig);
                
                draw_set_halign(fa_left);
                draw_set_color(c_white);
            }
            else
            {
                draw_set_halign(fa_center);
                draw_text(camerax() + 320, cameray() + my + 36 + (i * mspace), newfile);
                draw_set_halign(fa_left);
                draw_set_color(c_white);
            }
        }
        else
        {
            filesaved = stringsetloc("File Saved", "obj_savemenu_slash_Draw_0_gml_371_0");
            draw_set_halign(fa_center);
            if mpos == save_count
                draw_text(camerax() + 320, cameray() + my + 30 + (i * mspace), filesaved);
            else
                draw_text(camerax() + 320, cameray() + my + 36 + (i * mspace), filesaved);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
        }
    }
    
    draw_set_halign(fa_center);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}*/

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}

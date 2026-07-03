xx = __view_get(e__VW.XView, 0);
yy = __view_get(e__VW.YView, 0);

if (saved == 0)
    time_current = global.time;

scr_84_set_draw_font("main");

if (d == 2)
    scr_84_set_draw_font("mainbig");

if menuno == 0
{
    if (global.lang == "ja")
    {
        if (d == 1)
        {
            draw_set_color(c_white);
            draw_rectangle(54 + xx, 49 + yy, 265 + xx, 157 + yy, false);
            draw_set_color(c_black);
            draw_rectangle((57 * d) + xx, (52 * d) + yy, (262 * d) + xx, (154 * d) + yy, false);
        }
        else
        {
            scr_darkbox((54 * d) + xx, (49 * d) + yy, (265 * d) + xx, (157 * d) + yy);
            draw_set_color(c_black);
            draw_rectangle((64 * d) + xx, (59 * d) + yy, (255 * d) + xx, (147 * d) + yy, false);
        }
        
        draw_set_color(c_white);
        
        if (coord == 2)
            draw_set_color(c_yellow);
        
        draw_set_halign(fa_center);
        draw_text((160 * d) + xx, (60 * d) + yy, string_hash_to_newline(name));
        draw_set_halign(fa_left);
        
        if (d == 1)
            draw_text(76 + xx, 80 + yy, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_29_0") + string(love)));
        
        if (d == 2)
            draw_text((78 * d) + xx, (80 * d) + yy, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level)));
        
        draw_text((196 * d) + xx, (80 * d) + yy, scr_timedisp(time_current));
        draw_set_halign(fa_center);
        draw_text((160 * d) + xx, (100 * d) + yy, string_hash_to_newline(roomname));
        draw_set_halign(fa_left);
        
        if (coord == 0)
            draw_sprite(heartsprite, 0, xx + (83 * d), yy + (135 * d));
        
        if (coord == 1)
            draw_sprite(heartsprite, 0, xx + (173 * d), yy + (135 * d));
        
        if (coord < 2)
        {
            draw_text(xx + (95 * d), yy + (130 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_47_0")));
            draw_text(xx + (185 * d), yy + (130 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_48_0")));
        }
        else
        {
            draw_set_halign(fa_center);
            draw_text(xx + (160 * d), yy + (130 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_52_0")));
            draw_set_halign(fa_left);
        }
    }
    else
    {
        if (d == 1)
        {
            draw_set_color(c_white);
            draw_rectangle(54 + xx, 49 + yy, 265 + xx, 135 + yy, false);
            draw_set_color(c_black);
            draw_rectangle((57 * d) + xx, (52 * d) + yy, (262 * d) + xx, (132 * d) + yy, false);
        }
        else
        {
            scr_darkbox((54 * d) + xx, (49 * d) + yy, (265 * d) + xx, (135 * d) + yy);
            draw_set_color(c_black);
            draw_rectangle((64 * d) + xx, (59 * d) + yy, (255 * d) + xx, (125 * d) + yy, false);
        }
        
        draw_set_color(c_white);
        
        if (coord == 2)
            draw_set_color(c_yellow);
        
        if (global.flag[912] == 0)
        {
            draw_text((70 * d) + xx, (60 * d) + yy, string_hash_to_newline(name));
        }
        else
        {
            draw_set_font(fnt_ja_main);
            
            if (d == 2)
                draw_set_font(fnt_ja_mainbig);
            
            draw_text((70 * d) + xx, (60 * d) + yy, string_hash_to_newline(name));
            scr_84_set_draw_font("main");
            
            if (d == 2)
                scr_84_set_draw_font("mainbig");
        }
        
        if (d == 1)
            draw_text(140 + xx, 60 + yy, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_29_0") + string(love)));
        
        if (d == 2)
            draw_text((175 * d) + xx, (60 * d) + yy, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level)));
        
        draw_text((210 * d) + xx, (60 * d) + yy, scr_timedisp(time_current));
        draw_text((70 * d) + xx, (80 * d) + yy, string_hash_to_newline(roomname));
        
        if (coord == 0)
            draw_sprite(heartsprite, 0, xx + (71 * d), yy + (113 * d));
        
        if (coord == 1)
            draw_sprite(heartsprite, 0, xx + (161 * d), yy + (113 * d));
        
        if (coord < 2)
        {
            draw_text(xx + (85 * d), yy + (110 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_47_0")));
            draw_text(xx + (175 * d), yy + (110 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_48_0")));
        }
        else
        {
            draw_text(xx + (85 * d), yy + (110 * d), string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_52_0")));
        }
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
    scr_darkbox_black(xx + mx, yy + my, xx + mx + mwidth, yy + my + mheight);
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
    scr_darkbox_black(xx + mx, yy + my, xx + mx + mwidth, yy + my + mheight);
    
    draw_sprite_ext(spr_textbox_top, 0, xx + mx + 14, yy + my + ext_box, mwidth * 0.948, 2, 0, c_white, 1);
    for (var i = 0; i < save_count; i++)
        draw_sprite_ext(spr_textbox_top, 0, xx + mx + 14, yy + 208 + ext_box + (84 * i) + yoff, mwidth * 0.948, 2, 0, c_white, 1);
    
    if menuno == 2
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(xx + 320, yy + 32 + yoff, global.truename);
    draw_set_halign(fa_left);
    draw_text(xx + mx + 40, yy + 32 + yoff, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level)));
    draw_set_halign(fa_right);
    draw_text(xx + mx + 483, yy + 32 + yoff, scr_timedisp(time_current));
    draw_set_halign(fa_center);
    draw_text(xx + 320, yy + 64 + yoff, room_current);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    newfile = "what"
    if global.lang == "en"
        newfile = "New File"
    else
        newfile = "データなし"
    var mspace = 84;

    my += ext_box
    var preview_top_y = yy + my - (ext_box / 2) - 5
    my -= mspace * scroll_y

    var add_file_txt = "+ " + newfile + "..."
    var next_file_x = (xx + 320) - string_width(add_file_txt)

    var fstxt = "what"
    if global.lang == "en"
        fstxt = "File Saved"
    else
        fstxt = "セーブしました"
    
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

        var preview_bottom_y = yy + my + 16 + (i * mspace)

        if i == save_count
        {
            draw_set_halign(fa_center);
            if menuno == 2 && mpos == i
            {
                draw_set_color(c_yellow)
                draw_text(xx + 320, preview_bottom_y, fstxt);
            }
            else
                draw_text(xx + 320, preview_bottom_y, add_file_txt);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
            continue;
        }

        var base_y = yy + my + 20 + (i * mspace)
        var base_x = xx + mx + 40 + 24
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
                draw_text(xx + mx + 40 + 24, base_y, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level_file[i])));
                draw_set_halign(fa_right);
                draw_text(xx + mx + 483, base_y, scr_timedisp(time_file[i]));
                draw_set_halign(fa_center);
                if preview_type == 0
                    draw_text(xx + 320, base_y + 32, scr_roomname(roome_file[i]));
                
                if (!initlang_file[i])
                {
                    draw_text(xx + 320, base_y, name_file[i]);
                }
                else
                {
                    draw_set_font(fnt_ja_mainbig);
                    draw_text(xx + 320, base_y, name_file[i]);
                    
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
                draw_text(xx + 320, base_y + 16, newfile);
                draw_set_halign(fa_left);
                draw_set_color(c_white);
            }
        }
        else
        {
            draw_set_color(c_yellow)
            draw_set_halign(fa_center);
            draw_text(xx + 320, base_y + 16, fstxt);
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
        
        returntxt = scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_48_0");
        draw_text(xx + 320, preview_top_y, string_hash_to_newline(returntxt));
        draw_set_halign(fa_left);
        draw_set_color(c_white);
    }
    
    if (overwrite == 0 && menuno != 2)
    {
        if (mpos != -1)
        {
            if mpos == save_count
                draw_sprite(heartsprite, 0, (xx + 320) - (string_width(add_file_txt) / 2) - 32, (yy + my + (mspace * mpos) + 62) - 40 + 3);
            else
            {
                if (level_file[mpos] != 0)
                    draw_sprite(heartsprite, 0, xx + mx + 32, (yy + my + (mspace * mpos) + 62) - 34);
                else
                    draw_sprite(heartsprite, 0, (xx + 320) - (string_width(newfile) / 2) - 32, yy + my + 36 + (mpos * mspace) + (string_height(newfile) / 4));
            }
        }
        else
        {
            draw_sprite(heartsprite, 0, (xx + 320) - string_width(returntxt), yy + my - (ext_box / 2) + 4);
        }
    }
    
    if (overwrite == 1)
    {
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(xx - 10, yy - 10, xx + 640 + 10, yy + 480 + 10, 0);
        draw_set_alpha(1);
        saved = 2;
        scr_darkbox_black(xx + 10, yy + 100, (xx + 640) - 10, (yy + 480) - 100);
        overwritetext = "what"
        if global.lang == "en"
            overwritetext = "Overwrite Slot ~1?"
        else
            overwritetext = "スロット~1に上書きしますか？"
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(xx + 320, (((yy + 120) - 4) + 19) - 12, string_hash_to_newline(scr_84_get_subst_string(overwritetext, mpos + 1)));
        draw_set_color(c_yellow);
        var currentSpace = 70;
        var horzspace = 80;
        draw_set_halign(fa_left);
        draw_text(xx + horzspace, ((15 + yy + 180) - 30) + currentSpace, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level)));
        draw_set_halign(fa_right);
        draw_text((xx + 640) - horzspace, ((15 + yy + 180) - 30) + currentSpace, scr_timedisp(time_current));
        draw_set_halign(fa_center);
        draw_text(xx + 320, 15 + yy + 180 + currentSpace, room_current);
        
        // initlang for current file
        if global.flag[912]
            draw_set_font(fnt_ja_mainbig);
        
        draw_text(xx + 320, ((15 + yy + 180) - 30) + currentSpace, name_current);
        
        if (global.lang == "en")
            draw_set_font(fnt_mainbig);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(xx + horzspace, (15 + yy + 180) - 30, string_hash_to_newline(scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_33_0") + string(level_file[mpos])));
        draw_set_halign(fa_right);
        draw_text((xx + 640) - horzspace, (15 + yy + 180) - 30, scr_timedisp(time_file[mpos]));
        draw_set_halign(fa_center);
        draw_text(xx + 320, 15 + yy + 180, scr_roomname(roome_file[mpos]));
        
        if initlang_file[mpos]
            draw_set_font(fnt_ja_mainbig);
        
        draw_text(xx + 320, (15 + yy + 180) - 30, name_file[mpos]);
        
        if (global.lang == "en")
            draw_set_font(fnt_mainbig);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        savetxt = scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_47_0");
        returntxt = scr_84_get_lang_string("obj_savemenu_slash_Draw_0_gml_48_0");
        
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

scr_84_set_draw_font("main");

if (BGMADE == 1)
{
    ANIM_SINER += 1;
    ANIM_SINER_B += 1;
    BG_SINER += 1;
    
    if (BG_ALPHA < 0.5)
        BG_ALPHA += (0.04 - (BG_ALPHA / 14));
    
    if (BG_ALPHA > 0.5)
        BG_ALPHA = 0.5;
    
    __WAVEHEIGHT = 240;
    __WAVEWIDTH = 320;
    
    for (i = 0; i < (__WAVEHEIGHT - 50); i += 1)
    {
        __WAVEMINUS = BGMAGNITUDE * (i / __WAVEHEIGHT) * 1.3;
        
        if (__WAVEMINUS > BGMAGNITUDE)
            __WAVEMAG = 0;
        else
            __WAVEMAG = BGMAGNITUDE - __WAVEMINUS;
        
        draw_background_part_ext(IMAGE_MENU, 0, i, __WAVEWIDTH, 1, sin((i / 8) + (BG_SINER / 30)) * __WAVEMAG, (-10 + i) - (BG_ALPHA * 20), 1, 1, image_blend, BG_ALPHA * 0.8);
        draw_background_part_ext(IMAGE_MENU, 0, i, __WAVEWIDTH, 1, -sin((i / 8) + (BG_SINER / 30)) * __WAVEMAG, (-10 + i) - (BG_ALPHA * 20), 1, 1, image_blend, BG_ALPHA * 0.8);
    }
    
    T_SINER_ADD = (sin(ANIM_SINER_B / 10) * 0.6) - 0.25;
    
    if (T_SINER_ADD >= 0)
        TRUE_ANIM_SINER += T_SINER_ADD;
    
    draw_sprite_ext(IMAGE_MENU_ANIMATION, ANIM_SINER / 12, 0, ((10 - (BG_ALPHA * 20)) + __WAVEHEIGHT) - 70, 1, 1, 0, image_blend, BG_ALPHA * 0.46);
    draw_sprite_ext(IMAGE_MENU_ANIMATION, (ANIM_SINER / 12) + 0.4, 0, ((10 - (BG_ALPHA * 20)) + __WAVEHEIGHT) - 70, 1, 1, 0, image_blend, BG_ALPHA * 0.56);
    draw_sprite_ext(IMAGE_MENU_ANIMATION, (ANIM_SINER / 12) + 0.8, 0, ((10 - (BG_ALPHA * 20)) + __WAVEHEIGHT) - 70, 1, 1, 0, image_blend, BG_ALPHA * 0.7);
}

var pos = MENUCOORD[0]
if (MENU_NO == 2)
    pos = MENUCOORD[2]
if (MENU_NO == 3 || MENU_NO == 4 || MENU_NO == bottom_menu_copy_ver)
    pos = MENUCOORD[3];
if (MENU_NO == 5 || MENU_NO == 6 || MENU_NO == 7)
    pos = MENUCOORD[5]

var target_scroll_y = 0
var file_amt = get_file_amt()
if (pos > file_amt - 2)
    pos = file_amt - 2
if (pos > 1 && file_amt > 3)
    target_scroll_y = (YL + YS) * (pos - 1);

if (abs(scroll_y - target_scroll_y) < 1)
    scroll_y = target_scroll_y;

scroll_y += ceil(target_scroll_y - scroll_y) / scroll_speed

var cutoff_top_1    = (YL + YS) * -0.9;
var cutoff_top_2    = (YL + YS) * 0.5;
var cutoff_bottom_1 = (YL + YS) * 4.75;
var cutoff_bottom_2 = (YL + YS) * 5.4;

// this is 0 if no scroll is done, and 1 if one increment of scroll has been done
var scroll_progress = 0
if (file_amt > 3)
    scroll_progress = scroll_y / (YL + YS) * (2 - 1)

if (scroll_progress > 1)
    scroll_progress = 1

for (i = 0; i < ds_list_size(savefiles) + 1; i += 1)
{
    var create_new_text = i == ds_list_size(savefiles)

    var file_index = get_file_amt()
    var my_bsave = noone

    if (!create_new_text)
    {
        my_bsave = cur_file(i)
        if (my_bsave.is_completion)
            continue;

        file_index = my_bsave.true_file_index
    }

    BOX_X1 = 55;
    BOX_Y1 = 55 + ((YL + YS) * file_index);
    BOX_X2 = 55 + XL;
    BOX_Y2 = (55 + ((YL + YS) * file_index) + YL) - 1;
    BOX_Y1 -= scroll_y
    BOX_Y2 -= scroll_y
    var base_alpha = 1
    if (BOX_Y1 >= cutoff_bottom_1)
        base_alpha = scr_bettersaves_lin_convert(BOX_Y1, cutoff_bottom_1, cutoff_bottom_2, 1, 0)
    if (BOX_Y1 <= cutoff_top_2)
        base_alpha = scr_bettersaves_lin_convert(BOX_Y1, cutoff_top_2, cutoff_top_1, 1, 0)

    // out of sight, out of mind
    if (base_alpha <= 0)
        continue;

    var centx = 0
    var centy = 0
    if (TYPE != 1)
    {
        centx = 1
        centy = 1
    }
    if (TYPE == 1)
    {
        centx = 2
        centy = 2
    }

    PREV_MENU = MENU_NO;
    
    if (MENU_NO == 1)
        PREV_MENU = 0;
    
    if (MENU_NO == 4)
        PREV_MENU = 3;
    
    if (MENU_NO == 6)
        PREV_MENU = 5;
    
    if (MENU_NO == 7)
        PREV_MENU = 5;

    var draw_menu_no1_options = function(my_bsave, file_index, centx, centy, draw_sel_c = true, xoff = 0, yoff = 0)
    {
        if (TYPE == 0)
        {
            if (MENU_NO == 1)
            {
                SELTEXT_C = " ";
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_116_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_116_1");
                
                if my_bsave == -1 || !my_bsave.exists
                {
                    SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_117_0");
                    SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_117_1");
                }
            }
            
            if (MENU_NO == 4)
            {
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_119_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_119_1");
                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_119_2");
            }
            
            if (MENU_NO == 6)
            {
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_120_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_120_1");
                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_120_2");
            }
            
            if (MENU_NO == 7)
            {
                //SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_0");
                //SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_1");
                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_2");

                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_0");
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_1");
            }
        }
        else
        {
            if (MENU_NO == 1)
            {
                SELTEXT_C = " ";
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_128_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_128_1");
                
                if my_bsave == -1 || !my_bsave.exists
                {
                    SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_129_0");
                    SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_129_1");
                }
            }
            
            if (MENU_NO == 4)
            {
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_131_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_131_1");
                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_131_2");
            }
            
            if (MENU_NO == 6)
            {
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_132_0");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_132_1");
                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_132_2");
            }
            
            if (MENU_NO == 7)
            {
                //SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_133_0");
                //SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_133_1");
                SELTEXT_B = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_133_0");
                SELTEXT_A = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_133_1");

                SELTEXT_C = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_133_2");
            }
        }
        
        draw_set_color(COL_B);
        
        if (MENU_NO == 7)
            draw_set_color(c_red);

        // whatever just modify the argument
        centx += normalized(xoff)
        centy += normalized(yoff)
        
        if (draw_sel_c)
            draw_text_shadow_scaled_surf(centx + normalized(25), centy + normalized(5), SELTEXT_C);
        draw_set_color(COL_A);

        if (MENU_NO != 1 || my_bsave == -1 || !my_bsave.exists)
        {
            if (MENUCOORD[MENU_NO] == 0)
            {
                draw_set_color(COL_B);
                HEARTX = 75 + xoff;
                HEARTY = 81 + yoff + ((YL + YS) * MENUCOORD[PREV_MENU]);
            }
            
            draw_text_shadow_scaled_surf(centx + normalized(35), centy + normalized(22), SELTEXT_A);
            draw_set_color(COL_A);
            
            if (MENUCOORD[MENU_NO] == 1)
            {
                draw_set_color(COL_B);
                HEARTX = 165 + xoff;
                HEARTY = 81 + yoff + ((YL + YS) * MENUCOORD[PREV_MENU]);
            }

            draw_text_shadow_scaled_surf(centx + normalized(125), centy + normalized(22), SELTEXT_B);
        }
        else
        {
            var xsp = 12
            var txt_x = 15

            var copy_txt = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_199_0");
            var erase_txt = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_121_0")
            if (TYPE != 0)
            {
                erase_txt = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_201_1")
                copy_txt = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_201_0")
            }
            
            var draw_txt =
            [
                SELTEXT_A,
                copy_txt,
                erase_txt,
                SELTEXT_B,
            ]
            
            for (var j = 0; j < 4; j++)
            {
                draw_set_color(COL_A);
                if (MENUCOORD[MENU_NO] == j)
                {
                    draw_set_color(COL_B);
                    HEARTX = 43 + xoff + txt_x;
                    HEARTY = 81 + yoff + ((YL + YS) * MENUCOORD[PREV_MENU]);
                }
                draw_text_shadow_scaled_surf(centx + normalized(txt_x), centy + normalized(22), draw_txt[j]);

                txt_x += string_width(draw_txt[j]) + 2 + xsp
            }
        }
    }

    // new file text
    if (create_new_text)
    {
        var w = normalized(200)
        var h = normalized(20)
        if (MENU_NO == 1 && MENUCOORD[PREV_MENU] == file_index)
            h += normalized(40)
        if (!surface_exists(box_surf))
            box_surf = surface_create(w, h)
        if (surface_get_width(box_surf) != w || surface_get_height(box_surf) != h)
            surface_resize(box_surf, w, h)
        surface_set_target(box_surf)
        draw_clear_alpha(c_black, 0)
        draw_set_color(COL_A)
        if (MENUCOORD[PREV_MENU] == file_index && (MENU_NO != bottom_menu && MENU_NO != bottom_menu_copy_ver))
            draw_set_color(COL_B);
        var new_file_txt = "+ New File..."
        var copy_file_txt = "+ Copy to new file..."
        if (TYPE == 0)
        {
            new_file_txt = "+ CREATE A NEW"
            copy_file_txt = "+ MIRROR INTO ANOTHER"
        }

        var txt = new_file_txt

        if (MENU_NO == 3 || MENU_NO == bottom_menu_copy_ver)
            txt = copy_file_txt
            
        draw_text_shadow_scaled_surf(centx + normalized(15), centy, txt);
        if (MENU_NO == 1 && MENUCOORD[PREV_MENU] == file_index)
            draw_menu_no1_options(-1, file_index, centx, centy, false, 0, -5)

        surface_reset_target()
        draw_surface_ext(box_surf, BOX_X1 - (centx / surf_scale), BOX_Y1 - (centy / surf_scale), 1 / surf_scale, 1 / surf_scale, 0, c_white, base_alpha)
        draw_set_alpha(1)
        continue;
    }

    CONT_THIS = 0;
    
    if (MENUCOORD[0] == file_index && MENU_NO == 1)
        CONT_THIS = 1;
    
    if (MENUCOORD[3] == file_index && MENU_NO == 4)
        CONT_THIS = 4;
    
    if (MENUCOORD[5] == file_index && MENU_NO == 6)
        CONT_THIS = 6;
    
    if (MENUCOORD[5] == file_index && MENU_NO == 7)
        CONT_THIS = 7;

    var centx = 0
    var centy = 0
    if (TYPE != 1)
    {
        var w = normalized(XL + 2)
        var h = normalized(YL + 2)
        centx = normalized(1)
        centy = normalized(1)
        if (!surface_exists(box_surf))
            box_surf = surface_create(w, h)
        if (surface_get_width(box_surf) != w || surface_get_height(box_surf) != h)
            surface_resize(box_surf, w, h)
    }
    if (TYPE == 1)
    {
        var w = normalized(XL + 6)
        var h = normalized(YL + 6)
        centx = normalized(2)
        centy = normalized(2)
        if (!surface_exists(box_surf))
            box_surf = surface_create(w, h)
        if (surface_get_width(box_surf) != w || surface_get_height(box_surf) != h)
            surface_resize(box_surf, w, h)
    }

    surface_set_target(box_surf)
    draw_clear_alpha(c_black, 0)
        
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha) 
    draw_rectangle(centx, centy, normalized(XL + 2), normalized(YL + 1), false);
    gpu_set_blendmode(bm_normal)
    draw_set_alpha(1);
    draw_set_color(COL_A);

    var selected = MENUCOORD[PREV_MENU] == file_index && MENU_NO != bottom_menu && MENU_NO != bottom_menu_copy_ver
    
    if (selected)
        draw_set_color(COL_B);
    
    if (MENU_NO == 3 || MENU_NO == 4 || MENU_NO == bottom_menu_copy_ver)
    {
        if (MENUCOORD[2] == file_index)
        {
            draw_set_color(COL_PLUS);
            selected = true
        }
    }
    
    if (MENU_NO == 7 && MENUCOORD[5] == file_index)
        draw_set_color(c_red);
    
    if (TYPE != 1)
    {
        var col = draw_get_color();
        var alf = draw_get_alpha();
        draw_sprite_ext(spr_pxwhite, 0, 0, 0, normalized(XL + 1), normalized(1), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, 0, normalized(YL + 1), normalized(XL + 2), normalized(1), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, 0, 0, normalized(1), normalized(YL + 1), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, normalized(XL + 1), 0, normalized(1), normalized(YL + 1), 0, col, alf);
    }
    
    if (TYPE == 1)
    {
        var col = draw_get_color();
        var alf = draw_get_alpha();
        draw_sprite_ext(spr_pxwhite, 0, 0, 0, normalized(XL + 4), normalized(2), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, 0, normalized(YL + 1), normalized(XL + 4), normalized(2), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, 0, 0, normalized(2), normalized((YL - 1) + 4), 0, col, alf);
        draw_sprite_ext(spr_pxwhite, 0, normalized(XL + 2), 0, normalized(2), normalized((YL - 1) + 4), 0, col, alf);
    }
    
    if (CONT_THIS < 4)
    {
        if !my_bsave.exists
            scr_84_set_draw_font("main");
        else if my_bsave.initlang == 0
            draw_set_font(fnt_main);
        else if my_bsave.initlang == 1
            draw_set_font(fnt_ja_main);
        
        draw_text_shadow_scaled_surf(centx + normalized(25), centy + normalized(5), my_bsave.name);
        scr_84_set_draw_font("main");
        draw_set_halign(fa_right);
        draw_text_shadow_scaled_surf(centx + normalized(180), centy + normalized(5), my_bsave.time_string);
        draw_set_halign(fa_left);
    }

    var brightness = 0.6

    if (selected)
        brightness = 1

    var startx = (centx + normalized(XL)) - normalized(13)
    var x1 = startx
    var y1 = centy + 5
    var spacingx = -13
    var spacingy = 12
    for (var j = 0; j < array_length(my_bsave.icons); j++)
    {
        var icon = my_bsave.icons[j]

        draw_set_alpha(icon.alpha)
        if (icon.outline)
            draw_with_outline(icon.spr_index, icon.img_index, x1 + icon.xoff, y1 + icon.yoff, icon.outline_col, icon.outline_corners, brightness, surf_scale)
        else
            draw_with_darkness(icon.spr_index, icon.img_index, x1 + icon.xoff, y1 + icon.yoff, brightness, surf_scale)

        x1 += normalized(spacingx)
        if (x1 <= startx + (normalized(spacingx * 2)))
        {
            x1 = startx
            y1 += normalized(spacingy)
        }
    }

    draw_set_alpha(1)

    if (CONT_THIS >= 1)
        draw_menu_no1_options(my_bsave, file_index, centx, centy)
    else
        draw_text_shadow_width_scaled_surf(centx + normalized(25), centy + normalized(22), my_bsave.place, 180);

    surface_reset_target()
    draw_set_color(c_white)
    draw_surface_ext(box_surf, BOX_X1 - (centx / surf_scale), BOX_Y1 - (centy / surf_scale), 1 / surf_scale, 1 / surf_scale, 0, c_white, base_alpha)
    draw_set_alpha(1)
}

if (MENU_NO >= 0)
{
    if (MENU_NO == 0 || MENU_NO == 2 || MENU_NO == 3 || MENU_NO == 5)
    {
        if (MENUCOORD[MENU_NO] >= 0 && MENUCOORD[MENU_NO] <= get_file_amt())
        {
            HEARTX = 65;
            HEARTY = 72 + ((YL + YS) * MENUCOORD[MENU_NO]);
        }

        if (MENUCOORD[MENU_NO] == get_file_amt())
        {
            HEARTX = 55
            HEARTY = 72 + ((YL + YS) * MENUCOORD[MENU_NO]);
            HEARTY -= 12
        }
    }

    if (MENU_NO == bottom_menu)
    {
        /*if (MENUCOORD[MENU_NO] == bottom_menu_copy)
        {
            HEARTX = 40;
            HEARTY = 195;
        }
        
        if (MENUCOORD[MENU_NO] == bottom_menu_erase)
        {
            HEARTX = 125;
            HEARTY = 195;
        }*/
        
        if (MENUCOORD[MENU_NO] == bottom_menu_chselect)
        {
            if (global.lang == "en")
                HEARTX = 68;
            else
                HEARTX = 67;

            HEARTY = 9;
        }
        
        if (MENUCOORD[MENU_NO] == bottom_menu_lang)
        {
            HEARTX = 177;
            HEARTY = 9;
        }

        if (MENUCOORD[bottom_menu] == bottom_menu_quit)
        {
            if (global.lang == "en")
                HEARTX = 232;
            else
                HEARTX = 242;
            HEARTY = 9;
        }
    }

    if (MENU_NO == bottom_menu_copy_ver)
    {
        HEARTX = 232
        HEARTY = 9
    }
    
    if (MENU_NO == 2 || MENU_NO == 3 || MENU_NO == bottom_menu_copy_ver)
    {
        if !surface_exists(text_surf)
            text_surf = surface_create(300, 40)
        surface_set_target(text_surf)
        draw_clear_alpha(c_black, 0)

        CANCELTEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_189_0");
        
        if (TYPE == 1)
            CANCELTEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_190_0");
        
        draw_set_color(COL_A);
        
        if (MENU_NO == bottom_menu_copy_ver)
            draw_set_color(COL_B);
        
        draw_text_shadow(0, 0, CANCELTEXT);
        surface_reset_target()
        var scroll_alpha = 1.5 - scroll_progress
        if (scroll_alpha > 1)
            scroll_alpha = 1
        draw_set_alpha(scroll_alpha)
        draw_surface(text_surf, 245, 4)
        draw_set_alpha(1)
    }
    
    if (MENU_NO == 0 || MENU_NO == bottom_menu || MENU_NO == 1)
    {
        var scroll_alpha = 1.5 - scroll_progress

        if (scroll_alpha > 1)
            scroll_alpha = 1

        if (MENU_NO == bottom_menu)
        {
            bottom_menu_fade = true
            bottom_menu_alpha += text_fade_speed
            if (bottom_menu_alpha > 1)
                bottom_menu_alpha = 1
        }
        else
        {
            if (bottom_menu_fade)
            {
                bottom_menu_alpha -= text_fade_speed
                if (bottom_menu_alpha <= scroll_alpha)
                {
                    bottom_menu_alpha = scroll_alpha
                    bottom_menu_fade = false
                }
            }
            else
                bottom_menu_alpha = scroll_alpha
        }

        if (bottom_menu_alpha > 0)
        {
            if !surface_exists(text_surf)
                text_surf = surface_create(300, 40)
            surface_set_target(text_surf)
            draw_clear_alpha(c_black, 0)

            COPYTEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_199_0");
            ERASETEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_200_0");
            CHSELECTTEXT = (TYPE == 1) ? "Chapter Select" : "CHAPTER SELECT";
            
            if (global.lang == "ja")
            {
                CHSELECTTEXT = "チャプター選択";
                LANGUAGETEXT = "ENGLISH";
                
                if (TYPE == 1)
                    LANGUAGETEXT = "English";
            }
            else
            {
                LANGUAGETEXT = "日本語";
                
                if (TYPE == 1)
                    LANGUAGETEXT = "日本語";
            }
            
            /*if (TYPE == 1)
            {
                COPYTEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_201_0");
                ERASETEXT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_201_1");
            }
            
            draw_set_color(COL_A);
            
            if (MENUCOORD[bottom_menu] == bottom_menu_copy && MENU_NO == bottom_menu)
                draw_set_color(COL_B);
            
            draw_text_shadow(54, 190, COPYTEXT);
            draw_set_color(COL_A);
            
            if (MENUCOORD[bottom_menu] == bottom_menu_erase && MENU_NO == bottom_menu)
                draw_set_color(COL_B);
            
            draw_text_shadow(140, 190, ERASETEXT);
            draw_set_color(COL_A);*/

            draw_set_color(COL_A);
            
            if (MENUCOORD[bottom_menu] == bottom_menu_chselect && MENU_NO == bottom_menu)
                draw_set_color(COL_B);
            
            if (global.lang == "en")
                draw_text_shadow(2, 0, CHSELECTTEXT);
            else
                draw_text_shadow(0, 0, CHSELECTTEXT);

            draw_set_color(COL_A);
            
            if (MENUCOORD[bottom_menu] == bottom_menu_lang && MENU_NO == bottom_menu)
                draw_set_color(COL_B);
            
            var lang_offset = 0;
            
            if (global.lang == "en")
            {
                lang_offset -= 2;
                draw_set_font(fnt_ja_main);
            }
            else
            {
                draw_set_font(fnt_main);
            }
            
            draw_text_shadow(112 + lang_offset, 0, LANGUAGETEXT);
            scr_84_set_draw_font("main");
            
            if (!global.is_console)
            {
                QUITTEXT = "End Program";
                
                if (global.lang == "ja")
                    QUITTEXT = "終了";
                
                if (TYPE == 0)
                    QUITTEXT = string_upper(QUITTEXT);
                
                draw_set_color(COL_A);
                
                if (MENUCOORD[bottom_menu] == bottom_menu_quit && MENU_NO == bottom_menu)
                    draw_set_color(COL_B);
                
                if (global.lang == "ja")
                    draw_text_shadow(177, 0, QUITTEXT);
                else
                    draw_text_shadow(167, 0, QUITTEXT);
            }

            surface_reset_target()
            draw_set_alpha(bottom_menu_alpha)
            draw_surface(text_surf, 78, 4)
            draw_set_alpha(1)
        }
    }
    
    draw_set_font(fnt_main);
    
    if (TYPE == 1)
    {
        draw_set_alpha(0.4);
        draw_set_color(c_white);
        draw_text_transformed(195, 230, "DELTARUNE " + version_text + "(C) Toby Fox 2018-2026 ", 0.5, 0.5, 0);
    }
    else
    {
        draw_set_color(COL_A);
        draw_text_transformed(248, 230, version_text, 0.5, 0.5, 0);
        draw_set_color(c_white);
    }
    
    scr_84_set_draw_font("main");
    draw_set_alpha(1);
    
    if (MESSAGETIMER <= 0)
    {
        if (TYPE == 0)
        {
            if (MENU_NO == 0 || MENU_NO == 1)
                TEMPCOMMENT = " ";
            
            if (MENU_NO == 2)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_216_0");
            
            if (MENU_NO == 3)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_217_0");
            
            if (MENU_NO == 4)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_218_0");
            
            if (MENU_NO == 5 || MENU_NO == 6 || MENU_NO == 7)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_219_0");
        }
        
        if (TYPE == 1)
        {
            if (MENU_NO == 0 || MENU_NO == 1 || MENU_NO == bottom_menu)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_223_0");
            
            if (MENU_NO == 2)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_224_0");
            
            if (MENU_NO == 3)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_225_0");
            
            if (MENU_NO == 4)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_226_0");
            
            if (MENU_NO == 5 || MENU_NO == 6 || MENU_NO == 7)
                TEMPCOMMENT = scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_227_0");
        }
    }

    var scroll_alpha = 1 - (scroll_progress * 1.5)

    var main_menu = MENU_NO == 0 || MENU_NO == bottom_menu || MENU_NO == 1
    
    if main_menu && MESSAGETIMER < 10
    {
        if (!message_fade)
        {
            message_alpha = scroll_alpha
            if (message_alpha < 0)
                message_alpha = 0
        }
    }
    else
    {
        message_fade = true
        message_alpha += text_fade_speed
        if (message_alpha > 1)
            message_alpha = 1
    } 

    if (main_menu && MESSAGETIMER < 10 && message_fade)
    {
        // please select a file message
        var bland = TEMPCOMMENT == scr_84_get_lang_string("DEVICE_MENU_slash_Draw_0_gml_223_0") || TEMPCOMMENT == " "
        if (bland)
        {
            message_fade = false
            message_alpha = scroll_alpha
        }
        else
        {
            message_alpha -= text_fade_speed
            if message_alpha <= scroll_alpha
            {
                message_alpha = scroll_alpha
                message_fade = false
            }
        }
    }

    if (message_alpha > 0)
    {
        if !surface_exists(text_surf)
            text_surf = surface_create(300, 40)

        surface_set_target(text_surf)
        draw_clear_alpha(c_black, 0)
        draw_set_color(COL_B);
        draw_text_shadow(0, 0, TEMPCOMMENT);
        surface_reset_target()

        draw_set_alpha(message_alpha)

        draw_surface(text_surf, 40, 30)
        draw_set_alpha(1)
        MESSAGETIMER -= 1;
    }
}

if (MENU_NO != bottom_menu)
    HEARTY -= scroll_y

if (abs(HEARTX - HEARTXCUR) <= 2)
    HEARTXCUR = HEARTX;

if (abs(HEARTY - HEARTYCUR) <= 2)
    HEARTYCUR = HEARTY;

HEARTXCUR += ((HEARTX - HEARTXCUR) / 2);
HEARTYCUR += ((HEARTY - HEARTYCUR) / 2);

if (MENU_NO != bottom_menu)
    HEARTY += scroll_y
draw_sprite(spr_heartsmall, 0, HEARTXCUR, HEARTYCUR);

if (TYPE == 1)
    draw_set_color(c_white);
else
    draw_set_color(COL_A);

draw_set_font(fnt_main);
draw_text_shadow(__view_get(e__VW.XView, 0) + 8, __view_get(e__VW.YView, 0) + 4, "CHAPTER 1");
draw_set_color(c_white);

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

xx = __view_get(e__VW.XView, 0);
yy = __view_get(e__VW.YView, 0);
buffer -= 1;
if menuno == 0
{
    if (coord == 1 && buffer < 0)
    {
        if (button1_p())
        {
            coord = 99;
            endme = 1;
        }
    }

    if (coord < 2)
    {
        if (left_p() || right_p())
        {
            if (coord == 1)
                coord = 0;
            else
                coord = 1;
        }
    }

    if (coord == 0 && buffer < 0)
    {
        if (button1_p())
        {
            buffer = 3
            menuno = 1
            snd_play(snd_select)
        }
    }

    if (button2_p() && buffer < 0)
        endme = 1;
}

if (menuno == 1)
{
    var menuwidth = 60;
    var menuheight = 80;
    scr_darkbox_black(xx + 120, yy + 110, xx + 120 + menuwidth, yy + 110 + menuheight);

    if (overwrite == 0)
    {
        if (down_p())
            mpos++;
        
        if (up_p())
            mpos--;
        
        mpos = clamp(mpos, -1, save_count);
        
        if (button1_p() && buffer < 0)
        {
            if (mpos == -1)
            {
                menuno = 0;
                buffer = 3;
                mpos = global.filechoice;
                snd_play(snd_select);
            }
            else if (mpos != save_count && level_file[mpos] != 0 && mpos != global.filechoice)
            {
                overwrite = 0.5;
                buffer = 3;
                overcoord = 0;
            }
            else
            {
                menuno = 2;
                global.filechoice = mpos;
                snd_play(snd_save);
                scr_save();
                saved = 1;
                coord = 1;
                buffer = 3;
                
                if (d == 2)
                {
                    name = global.truename;
                    love = global.llv;
                }
                
                scr_roomname(room);
                level = global.lv;
                time = global.time;
                minutes = floor(time / 1800);
                seconds = round(((time / 1800) - minutes) * 60);
                
                if (seconds == 60)
                    seconds = 59;
                
                if (seconds < 10)
                    seconds = "0" + string(seconds);
            }
        }
        
        if (button2_p() && buffer < 0)
        {
            menuno = 0;
            buffer = 3;
            mpos = global.filechoice;
            snd_play(snd_select);
        }
    }

    if overwrite == 1
    {
        if (button1_p() && buffer < 0)
        {
            if (overcoord == 0)
            {
                overwrite = 0
                menuno = 2;
                global.filechoice = mpos;
                snd_play(snd_save);
                scr_save();
                saved = 1;
                coord = 1;
                buffer = 3;
                
                if (d == 2)
                {
                    name = global.truename;
                    love = global.llv;
                }
                
                scr_roomname(room);
                level = global.lv;
                time = global.time;
                minutes = floor(time / 1800);
                seconds = round(((time / 1800) - minutes) * 60);
                
                if (seconds == 60)
                    seconds = 59;
                
                if (seconds < 10)
                    seconds = "0" + string(seconds);
            }
            else
            {
                overwrite = 0;
                buffer = 3;
                saved = 0;
            }
        }
        
        if (button2_p() && buffer < 0)
        {
            overwrite = 0;
            buffer = 3;
            saved = 0;
        }
    }

    if (overwrite == 0.5)
        overwrite = 1;
}

if menuno == 2
{
    if (button1_p() || button2_p()) && buffer < 0
        endme = 1
}

if (endme == 1)
{
    global.interact = 0;
    
    with (obj_mainchara)
        onebuffer = 3;
    
    instance_destroy();
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

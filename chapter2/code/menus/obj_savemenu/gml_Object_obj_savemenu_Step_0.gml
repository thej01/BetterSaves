buffer -= 1;

if (menuno == 0)
{
    if (xcoord == 2 && buffer < 0)
    {
        if (button1_p())
        {
            xcoord = 99;
            endme = 1;
        }
    }
    
    if (xcoord < 2)
    {
        if (left_p() || right_p())
        {
            if (xcoord == 1)
                xcoord = 0;
            else
                xcoord = 1;
        }
    }
    
    if (type == 1)
    {
        if (up_p() || down_p())
        {
            if (ycoord == 1)
                ycoord = 0;
            else
                ycoord = 1;
        }
    }
    
    if (xcoord == 0 && ycoord == 0 && buffer < 0)
    {
        if (button1_p())
        {
            menuno = 1;
            buffer = 3;
            snd_play(snd_select);
        }
    }
    
    if (button1_p() && xcoord == 1 && ycoord == 0 && buffer < 0)
        endme = 1;
    
    if (button1_p() && xcoord == 0 && ycoord == 1 && buffer < 0)
    {
        global.interact = 1;
        menu = instance_create(0, 0, obj_fusionmenu);
        menu.type = 4;
        endme = 2;
    }
    
    if (button1_p() && xcoord == 1 && ycoord == 1 && buffer < 0 && haverecruited)
    {
        global.interact = 1;
        menu = instance_create(0, 0, obj_fusionmenu);
        menu.type = 3;
        menu.subtype = recruitsubtype;
        endme = 2;
    }
    
    if (button2_p() && buffer < 0 && endme == 0)
        endme = 1;
    
    if (endme == 1)
    {
        global.interact = 0;
        
        with (obj_mainchara)
            onebuffer = 3;
        
        instance_destroy();
    }
    
    if (endme == 2)
    {
        with (obj_mainchara)
            onebuffer = 3;
        
        instance_destroy();
    }
}

if (menuno == 1)
{
    var menuwidth = 60;
    var menuheight = 80;
    scr_darkbox_black(camerax() + 120, cameray() + 110, camerax() + 120 + menuwidth, cameray() + 110 + menuheight);

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
            else if mpos == save_count
            {
                menuno = 2;
                global.filechoice = mpos;
                snd_play(snd_save);
                scr_save();
                saved = 1;
                xcoord = 2;
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
            else if (level_file[mpos] != 0 && mpos != global.filechoice)
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
                xcoord = 2;
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
                xcoord = 2;
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
    if (button1_p() || button2_p())
    {
        if (buffer < 0)
        {
            global.interact = 0;
            
            with (obj_mainchara)
                onebuffer = 3;
            
            instance_destroy();
        }
    }
}

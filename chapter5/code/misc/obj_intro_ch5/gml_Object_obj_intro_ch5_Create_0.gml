turnofflayers("DEBUG");

if (scr_is_switch_os())
    instance_create_depth(0, 0, 0, obj_switchAsyncHelper);

con = 0;
timer = 0;
bgm = -1;
bgmPos = 0;
debug_force_nofiles = false;
skip_time = 10;
skip_safety = 0;
snd_free_all();
var CH = string(global.chapter);
files_exist = scr_bettersaves_any_saves_simple()
init = 0;
type = 0;
roomCenterX = room_width * 0.5;
roomCenterY = room_height * 0.5;
logoDel = scr_marker_fancy(roomCenterX, roomCenterY, 7104);
logoDel.image_alpha = 0;
logoDel.image_index = 0;
logoDel.depth = 19900;
logoDel.offset = 32;
logoTa = scr_marker_fancy(roomCenterX, roomCenterY, 7104);
logoTa.image_alpha = 0;
logoTa.image_index = 1;
logoTa.depth = 19900;
logoTa.offset = 169;
logoRune = scr_marker_fancy(roomCenterX, roomCenterY, 7104);
logoRune.image_alpha = 0;
logoRune.image_index = 2;
logoRune.depth = 19900;
logoRune.offset = 284;
logoAll = scr_marker_fancy(roomCenterX, roomCenterY, 2769);
logoAll.image_alpha = 0;
logoAll.image_index = 2;
logoAll.depth = 20000;
logoAll.image_xscale = 2;
logoAll.image_yscale = 2;
logoAll.timer = 0;
logoAll.timerPace = 0.03;

with (logoAll)
    scr_shoujo_setup();

logoShoujoSparkles = function()
{
    if (sparkling)
    {
    }
};

logoShoujoDraw = function()
{
    timer += timerPace;
    scr_shoujo_draw_on(timer);
    draw_self();
    shader_replace_simple_reset_hook();
};

logoAll.draw_func = method(logoAll.id, logoShoujoDraw);
logoParts = [logoDel, logoTa, logoRune];

for (var i = 0; i < 3; i++)
{
    logoParts[i].sparkling = true;
    logoParts[i].step_func = method(logoParts[i].id, logoShoujoSparkles);
    logoParts[0].sparkling = true;
}

bigSparkleStep = function()
{
    image_alpha = main_alpha * scr_wave(0.2, 1, 1 + fadespeed, fadeoffset);
    speed = main_alpha * 0.25;
};

bigSparkles = findspriteinfo_all(2350);

for (var i = 0; i < array_length(bigSparkles); i++)
{
    bigSparkles[i] = scr_makemarker_fromstruct(bigSparkles[i], true);
    bigSparkles[i].step_func = method(bigSparkles[i].id, bigSparkleStep);
    bigSparkles[i].fadespeed = random(0.5);
    bigSparkles[i].fadeoffset = random(30);
    bigSparkles[i].main_alpha = 0;
    bigSparkles[i].image_speed = 0;
    bigSparkles[i].direction = point_direction(roomCenterX, roomCenterY, bigSparkles[i].x, bigSparkles[i].y);
}

logoHeart = scr_marker(roomCenterX, roomCenterY, IMAGE_LOGO_CENTER);
logoHeart.image_alpha = 0;
logoHeart.depth = 21000;
logoHeart.image_xscale = 2;
logoHeart.image_yscale = 2;
black_all = scr_marker(0, 0, spr_pixel_white);
black_all.image_blend = c_black;
black_all.depth = -999;
black_all.image_xscale = 500;
black_all.image_yscale = 500;
black_all.visible = true;
black_all.image_alpha = 0;
chapter5_text_alpha = 0;
skipped = false;

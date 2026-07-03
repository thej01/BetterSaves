function scr_bettersaves_datafixerupper()
{
    scr_bettersaves_debug("Running datafixerupper (if needed)")

    var save_ver = scr_bettersaves_dfu_determine_save_version();
    scr_bettersaves_debug("Determined save version: " + string(save_ver))

    if (save_ver == global.bettersaves_mod_version)
    {
        scr_bettersaves_debug(string("Save version ({0}) is the same as current, skipping DFU...", save_ver))
        return;
    }
    else
    {
        scr_bettersaves_debug(string("Save version ({0}) is not the same as current ({1}), backing up save files...", save_ver, global.bettersaves_mod_version))
        scr_bettersaves_create_backup()
    }

    scr_bettersaves_dfu_convert_v5(save_ver)

    /*  Update save version in chapter info(s)
    for (var ch = 1; ch < (global.bettersaves_max_chapters + 1); ch++)
    {
        ossafe_ini_open(scr_bettersaves_chapter_info_filename(ch));
        scr_bettersaves_write_versionnum();
        ossafe_ini_close();
    }*/
}

function scr_bettersaves_dfu_determine_if_backup(save_ver)
{
    if (save_ver <= 5)
        return true;
    return false;
}

function scr_bettersaves_dfu_determine_save_version()
{
    // search for old v5 directories
    if (!global.is_console && ossafe_directory_exists(game_save_id + scr_bettersaves_folder_name(1)))
        return 5;
    return global.bettersaves_mod_version;
}

function scr_bettersaves_dfu_convert_v5(save_ver)
{
    if (save_ver > 5)
        return;

    scr_bettersaves_debug("v5 save directories found, transfering any existing files.")

    var chapter_highest_completion_index = array_create(global.bettersaves_max_chapters + 1, 5)
    var i = 1
    // this is fine probably
    while true
    {
        var dir = game_save_id + scr_bettersaves_folder_name(i)

        if (string_trim(dir) == "")
        {
            scr_bettersaves_debug(string("[ERROR: batch {0} directory is blank?? ending at batch {1}]", i, i - 1));
            break;
        }

        if (ossafe_directory_exists(dir))
        {
            scr_bettersaves_debug(string("[Batch {0} directory: {1}]", i, dir))
            scr_bettersaves_debug(string("[Moving content from BATCH {0}]", i))
            for (var ch = 1; ch < (global.bettersaves_max_chapters + 1); ch++)
            {
                scr_bettersaves_debug(string("[Moving files from CHAPTER {0}] (if any exist)", ch))
                var cur_index = (i * 3)
                for (var subindex = 0; subindex < 6; subindex++)
                {
                    var file = scr_bettersaves_file_struct(cur_index, subindex >= 3, ch);
                    var file_dir = scr_bettersaves_file_name_from_struct(file, file.chapter, true, "", false)
                    
                    if (ossafe_file_exists(file_dir))
                    {
                        if (file.is_completion && chapter_highest_completion_index[ch] < file.true_file_index)
                        {
                            chapter_highest_completion_index[ch] = file.true_file_index
                            scr_bettersaves_debug(string("[Updated CHAPTER {0} highest file completion index to {1}]", ch, chapter_highest_completion_index[ch]))
                        }

                        var new_dir = scr_bettersaves_file_name_from_struct(file, file.chapter, false, "", false)
                        ossafe_file_copy(file_dir, new_dir);
                        scr_bettersaves_debug(string("[Moved SAVE file] {0} -> {1}]", file_dir, new_dir))
                    }

                    for (var trackedFile = 0; trackedFile < ds_list_size(global.bettersaves_tracked_files); trackedFile++)
                    {
                        var tracked = ds_list_find_value(global.bettersaves_tracked_files, trackedFile)
                        if (tracked.append_type != "per_chapter_file")
                            continue;
                        var tracked_from = scr_bettersaves_get_track_filename(tracked, file, true, false)

                        if ossafe_file_exists(tracked_from)
                        {
                            var tracked_to = scr_bettersaves_get_track_filename(tracked, file, false, false)
                            ossafe_file_copy(tracked_from, tracked_to)
                            scr_bettersaves_debug(string("[Moved PER CHAPTER FILE TRACKED file {0}] {1} -> {2}]", tracked.file_name, tracked_from, tracked_to))
                        }
                    }

                    cur_index++;
                }

                for (var trackedFile = 0; trackedFile < ds_list_size(global.bettersaves_tracked_files); trackedFile++)
                {
                    var tracked = ds_list_find_value(global.bettersaves_tracked_files, trackedFile)
                    if (tracked.append_type != "per_file")
                        continue;
                    var tracked_from = scr_bettersaves_get_track_filename(tracked, file, true, false)
                    
                    if ossafe_file_exists(tracked_from)
                    {
                        var tracked_to = scr_bettersaves_get_track_filename(tracked, file, false, false)
                        ossafe_file_copy(tracked_from, tracked_to)
                        scr_bettersaves_debug(string("[Moved PER FILE TRACKED file {0}] {1} -> {2}]", tracked.file_name, tracked_from, tracked_to))
                    }
                }
            }
            scr_bettersaves_debug(string("[Finished moving content from BATCH {0}]", i))

            // im lazy
            // theres a lot of edge cases to check for here and i really dont wanna put in the effort tbh
            // you shouldnt put important files in these folders or any save game directory ofc. You can recover anything lost with the backup system anyway.
            ossafe_directory_destroy(dir)

            scr_bettersaves_debug(string("[Clearing BATCH {0} folder.]", i))

            scr_bettersaves_debug(string("[Finished clearing BATCH {0} folder.]", i))
        }
        // No more batch folders, stop
        else
            break;
        i++
    }

    scr_bettersaves_debug("Creating bettersavesinfo files...")

    for (var ch = 1; ch < (global.bettersaves_max_chapters + 1); ch++)
    {
        scr_bettersaves_save_chapter_info(chapter_highest_completion_index[ch], ch);
        scr_bettersaves_debug(string("[Saved bettersavesinfo for CHAPTER {0}]", ch))
    }

    scr_bettersaves_debug("Created bettersavesinfo files.")

    scr_bettersaves_debug("DFU for version 5 completed!")
}
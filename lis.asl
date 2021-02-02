state("LifeIsStrange") 
{
    bool loading_chapter : "LifeIsStrange.exe", 0x1234AB0;
    // 0/65: not moving/walking
    // 260: running
    int running : "MSCTF.dll", 0xC1FD8;
    // 0 (int: -1): paused/tabbed
    // 1 (int: 2): playing
    bool playing : "LifeIsStrange.exe", 0x111B3C0;
    // 0: not in main menu
    // 1 (int: 22): in main menu
    bool main_menu : "LifeIsStrange.exe", 0x12352D4;
}

init 
{
    vars.locked = true;
}

start
{
    if (!old.loading_chapter && current.loading_chapter) {
        return true;
    }
}

split
{
    if (current.loading_chapter && !vars.locked) {
        vars.locked = true;
        return true;
    }
}

reset
{
    if (!old.main_menu && current.main_menu) {
        return true;
    }
}

update
{
    if (current.running == 260) {
        vars.locked = false;
    }
    if (!current.playing) {
        vars.locked = true;
    }
}

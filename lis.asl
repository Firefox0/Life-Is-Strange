state("LifeIsStrange") 
{
    int scene : "LifeIsStrange.exe", 0x1208C5C;
    // 0/65: not moving/walking
    // 260: running
    int running : "MSCTF.dll", 0xC1FD8;
    // 2: unpaused
    // -1: paused/tabbed
    int paused : "LifeIsStrange.exe", 0x111B3C0;
    // 0: ingame
    // 22: menu
    int playing : "LifeIsStrange.exe", 0x12352D4;
}

init 
{
    vars.locked = true;
}

start
{
    if (current.playing != 22 && old.scene != current.scene) {
        return true;
    }
}

split
{
    if ((old.scene != current.scene) && !vars.locked) {
        vars.locked = true;
        return true;
    }
}

reset
{
    if (old.playing == 0 && current.playing == 22) {
        return true;
    }
}

update
{
    if (current.running == 260) {
        vars.locked = false;
    }
    if (current.paused != 2) {
        vars.locked = true;
    }
}

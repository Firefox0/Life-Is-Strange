state("LifeIsStrange") 
{
    int scene : "LifeIsStrange.exe", 0x1208C5C;
    // 0/65: not moving/walking
    // 260: running
    int running : "MSCTF.dll", 0xC1FD8;
    // 2: unpaused
    // -1: paused/tabbed
    int paused : "LifeIsStrange.exe", 0x111B3C0;
}

init 
{
    vars.locked = true;
}

start
{
    return old.scene != current.scene;
}

split
{
    if ((old.scene != current.scene) && !vars.locked) {
        vars.locked = true;
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

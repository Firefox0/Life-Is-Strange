state("LifeIsStrange") 
{
    int scene : "LifeIsStrange.exe", 0x1208C5C;
    int running : "MSCTF.dll", 0xC1FD8;
}

init 
{
    vars.moved = false;
}

start
{
    return old.scene != current.scene;
}

split
{
    if ((old.scene != current.scene) && vars.moved) {
        vars.moved = false;
        return true;
    }
}

update
{
    if (current.running == 260) {
        vars.moved = true;
    }
}

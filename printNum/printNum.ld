MEMORY
{
   BRAM (RWX) : ORIGIN = 0x0000, LENGTH = 0x2000
}
SECTIONS
{
    everything :
    {
	. = ALIGN(4);
	start.o (.text)
        *(.*)
    } >BRAM
}
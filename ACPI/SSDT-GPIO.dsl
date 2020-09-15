DefinitionBlock ("", "SSDT", 2, "hack", "GPI0", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)    // (from opcode)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }
    }
}

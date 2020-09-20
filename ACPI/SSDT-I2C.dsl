//Not Fix yet.
DefinitionBlock ("", "SSDT", 2, "AMDS", "_I2C", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPDE, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPDE.SBFG, BuffObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPDE.SBFI, IntObj)    // (from opcode)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Scope (_SB.PCI0.I2C0.TPDE)
    {
        Name (SBFG, ResourceTemplate ()
        {
            GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
               "\\ _SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x3A // Try this if the first one doesn't work: 0x10A
                }
        })
        Name (SBFX, ResourceTemplate ()
        {
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,,)
            {
                0x00000052,
            }
        })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                If (_OSI ("Darwin"))
                {
                    Return (ConcatenateResTemplate (SBFI, SBFG))
                }
                Else
                {
                    Return (Buffer (Zero){})
                }
            }
        }
    }


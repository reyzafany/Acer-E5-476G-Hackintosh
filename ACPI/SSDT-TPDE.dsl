// Require _CRS (045F4352 53) to XCRS (04584352 53) rename patch
DefinitionBlock ("", "SSDT", 2, "AMDS", "I2Cpatch", 0x00000000)
{
    External (_SB_.PCI0.I2C0.TPDE, DeviceObj)    // (from opcode)

    Scope (_SB.PCI0.I2C0.TPDE)
    {
        Name (SBFZ, ResourceTemplate ()
        {
            GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                "\\ _SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x003A
                }
        })
        Name (SBFX, ResourceTemplate ()
        {
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000052,
            }
        })
        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            Name (SBFI, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Return (ConcatenateResTemplate (SBFI, SBFZ))
        }
    }
}


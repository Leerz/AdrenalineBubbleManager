--CRC for prks
-- default values modules AdrenalineBooter v1.3 for adrenaline v7.0
__CRCADRBOOTER  = 0x039095FD
__CRCKERNEL     = 0xC9F84053
__CRCUSER       = 0xF5116106
__CRCVSH        = 0x485293A1
__CRCBOOTCONV   = 0xD072FE17

ADRENALINE = "ux0:app/PSPEMUCFW"
MODULES = {
  { fullpath = ADRENALINE.."/sce_module/adrbubblebooter.suprx",   path = "sce_module/adrbubblebooter.suprx",   crc = __CRCADRBOOTER },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_kernel.skprx", path = "sce_module/adrenaline_kernel.skprx", crc = __CRCKERNEL  },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_user.suprx",   path = "sce_module/adrenaline_user.suprx",   crc = __CRCUSER  },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_vsh.suprx",    path = "sce_module/adrenaline_vsh.suprx",    crc = __CRCVSH  },
  { fullpath = ADRENALINE.."/sce_module/bootconv.suprx",          path = "sce_module/bootconv.suprx",          crc = __CRCBOOTCONV }
}

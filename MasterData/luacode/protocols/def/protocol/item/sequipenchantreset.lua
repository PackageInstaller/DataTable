local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEquipEnchantReset = dataclass("SEquipEnchantReset", require("framework.net.protocol"))
SEquipEnchantReset.ProtocolType = 1252
SEquipEnchantReset.MaxSize = 65535

function SEquipEnchantReset:Ctor(client)
  SEquipEnchantReset.super.Ctor(self, client)
end

function SEquipEnchantReset:Marshal(buffer)
  return true
end

function SEquipEnchantReset:Unmarshal(buffer)
  local ret = true
  return ret
end

return SEquipEnchantReset

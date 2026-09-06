local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckSevenPopGiftStatus = dataclass("CCheckSevenPopGiftStatus", require("framework.net.protocol"))
CCheckSevenPopGiftStatus.ProtocolType = 2745
CCheckSevenPopGiftStatus.MaxSize = 65535

function CCheckSevenPopGiftStatus:Ctor(client)
  CCheckSevenPopGiftStatus.super.Ctor(self, client)
end

function CCheckSevenPopGiftStatus:Marshal(buffer)
  return true
end

function CCheckSevenPopGiftStatus:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCheckSevenPopGiftStatus

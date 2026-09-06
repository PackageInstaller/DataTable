local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFreeLevelGiftIcon = dataclass("SFreeLevelGiftIcon", require("framework.net.protocol"))
SFreeLevelGiftIcon.ProtocolType = 3641
SFreeLevelGiftIcon.MaxSize = 65535

function SFreeLevelGiftIcon:Ctor(client)
  SFreeLevelGiftIcon.super.Ctor(self, client)
end

function SFreeLevelGiftIcon:Marshal(buffer)
  return true
end

function SFreeLevelGiftIcon:Unmarshal(buffer)
  local ret = true
  return ret
end

return SFreeLevelGiftIcon

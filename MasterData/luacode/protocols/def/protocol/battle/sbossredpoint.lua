local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBossRedPoint = dataclass("SBossRedPoint", require("framework.net.protocol"))
SBossRedPoint.ProtocolType = 4128
SBossRedPoint.MaxSize = 65535

function SBossRedPoint:Ctor(client)
  SBossRedPoint.super.Ctor(self, client)
end

function SBossRedPoint:Marshal(buffer)
  return true
end

function SBossRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SBossRedPoint

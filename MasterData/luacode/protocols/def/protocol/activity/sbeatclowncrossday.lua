local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBeatClownCrossDay = dataclass("SBeatClownCrossDay", require("framework.net.protocol"))
SBeatClownCrossDay.ProtocolType = 2622
SBeatClownCrossDay.MaxSize = 65535

function SBeatClownCrossDay:Ctor(client)
  SBeatClownCrossDay.super.Ctor(self, client)
end

function SBeatClownCrossDay:Marshal(buffer)
  return true
end

function SBeatClownCrossDay:Unmarshal(buffer)
  local ret = true
  return ret
end

return SBeatClownCrossDay

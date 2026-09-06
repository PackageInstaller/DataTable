local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CWeekBossTalent = dataclass("CWeekBossTalent", require("framework.net.protocol"))
CWeekBossTalent.ProtocolType = 4143
CWeekBossTalent.MaxSize = 65535

function CWeekBossTalent:Ctor(client)
  CWeekBossTalent.super.Ctor(self, client)
end

function CWeekBossTalent:Marshal(buffer)
  return true
end

function CWeekBossTalent:Unmarshal(buffer)
  local ret = true
  return ret
end

return CWeekBossTalent

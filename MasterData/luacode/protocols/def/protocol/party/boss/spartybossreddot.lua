local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPartyBossRedDot = dataclass("SPartyBossRedDot", require("framework.net.protocol"))
SPartyBossRedDot.ProtocolType = 5042
SPartyBossRedDot.MaxSize = 65535
SPartyBossRedDot.flag = 0

function SPartyBossRedDot:Ctor(client)
  SPartyBossRedDot.super.Ctor(self, client)
end

function SPartyBossRedDot:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.flag) then
    return false
  end
  return true
end

function SPartyBossRedDot:Unmarshal(buffer)
  local ret = true
  ret, self.flag = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPartyBossRedDot

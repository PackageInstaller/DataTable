local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRequestPartyBossRank = dataclass("CRequestPartyBossRank", require("framework.net.protocol"))
CRequestPartyBossRank.ProtocolType = 5043
CRequestPartyBossRank.MaxSize = 65535
CRequestPartyBossRank.bossid = 0

function CRequestPartyBossRank:Ctor(client)
  CRequestPartyBossRank.super.Ctor(self, client)
end

function CRequestPartyBossRank:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  return true
end

function CRequestPartyBossRank:Unmarshal(buffer)
  local ret = true
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRequestPartyBossRank

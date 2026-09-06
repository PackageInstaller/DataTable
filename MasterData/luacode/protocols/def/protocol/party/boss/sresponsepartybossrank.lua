local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SResponsePartyBossRank = dataclass("SResponsePartyBossRank", require("framework.net.protocol"))
SResponsePartyBossRank.ProtocolType = 5044
SResponsePartyBossRank.MaxSize = 65535
SResponsePartyBossRank.bossid = 0

function SResponsePartyBossRank:Ctor(client)
  SResponsePartyBossRank.super.Ctor(self, client)
  self.ranking = {}
  self.myrank = require("protocols.bean.protocol.party.boss.partybosschallenge").Create()
end

function SResponsePartyBossRank:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  local length = table.slen(self.ranking)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.ranking[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.myrank:Marshal(buffer) then
    return false
  end
  return true
end

function SResponsePartyBossRank:Unmarshal(buffer)
  local ret = true
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.ranking[i] = require("protocols.bean.protocol.party.boss.partybosschallenge").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.myrank:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SResponsePartyBossRank

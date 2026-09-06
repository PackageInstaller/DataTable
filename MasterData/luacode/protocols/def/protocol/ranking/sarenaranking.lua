local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SArenaRanking = dataclass("SArenaRanking", require("framework.net.protocol"))
SArenaRanking.ProtocolType = 3508
SArenaRanking.MaxSize = 655350
SArenaRanking.index = 0

function SArenaRanking:Ctor(client)
  SArenaRanking.super.Ctor(self, client)
  self.ranking = {}
  self.playerRanking = require("protocols.bean.protocol.ranking.arenaranking").Create()
end

function SArenaRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
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
  if not self.playerRanking:Marshal(buffer) then
    return false
  end
  return true
end

function SArenaRanking:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.ranking[i] = require("protocols.bean.protocol.ranking.arenaranking").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.playerRanking:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SArenaRanking

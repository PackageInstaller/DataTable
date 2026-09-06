local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSimpleRank = dataclass("SSimpleRank", require("framework.net.protocol"))
SSimpleRank.ProtocolType = 3518
SSimpleRank.MaxSize = 655350
SSimpleRank.rankType = 0
SSimpleRank.rankId = 0

function SSimpleRank:Ctor(client)
  SSimpleRank.super.Ctor(self, client)
  self.ranking = {}
  self.playerRanking = require("protocols.bean.protocol.ranking.simplerank").Create()
end

function SSimpleRank:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankId) then
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

function SSimpleRank:Unmarshal(buffer)
  local ret = true
  ret, self.rankType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rankId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.ranking[i] = require("protocols.bean.protocol.ranking.simplerank").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.playerRanking:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSimpleRank

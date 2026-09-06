local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CArenaRanking = dataclass("CArenaRanking", require("framework.net.protocol"))
CArenaRanking.ProtocolType = 3507
CArenaRanking.MaxSize = 65535
CArenaRanking.index = 0
CArenaRanking.RANK_TYPE_CURRENT = 0
CArenaRanking.RANK_TYPE_TOTAL = 1

function CArenaRanking:Ctor(client)
  CArenaRanking.super.Ctor(self, client)
end

function CArenaRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.index) then
    return false
  end
  return true
end

function CArenaRanking:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArenaRanking

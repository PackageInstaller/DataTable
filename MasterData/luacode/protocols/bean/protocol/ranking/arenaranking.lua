local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ArenaRanking = dataclass("ArenaRanking")
ArenaRanking.rank = 0
ArenaRanking.pithy = 0
ArenaRanking.NOT_IN_RANK = -1

function ArenaRanking:Ctor()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
end

function ArenaRanking:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.pithy) then
    return false
  end
  return true
end

function ArenaRanking:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.pithy = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ArenaRanking

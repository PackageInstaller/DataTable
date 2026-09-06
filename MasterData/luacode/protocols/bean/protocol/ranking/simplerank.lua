local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SimpleRank = dataclass("SimpleRank")
SimpleRank.rank = 0
SimpleRank.score = 0
SimpleRank.NOT_IN_RANK = -1

function SimpleRank:Ctor()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
end

function SimpleRank:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.score) then
    return false
  end
  return true
end

function SimpleRank:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SimpleRank

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAlchemyRankLevelUp = dataclass("SAlchemyRankLevelUp", require("framework.net.protocol"))
SAlchemyRankLevelUp.ProtocolType = 2371
SAlchemyRankLevelUp.MaxSize = 65535
SAlchemyRankLevelUp.level = 0
SAlchemyRankLevelUp.stage = 0
SAlchemyRankLevelUp.exp = 0

function SAlchemyRankLevelUp:Ctor(client)
  SAlchemyRankLevelUp.super.Ctor(self, client)
end

function SAlchemyRankLevelUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exp) then
    return false
  end
  return true
end

function SAlchemyRankLevelUp:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAlchemyRankLevelUp

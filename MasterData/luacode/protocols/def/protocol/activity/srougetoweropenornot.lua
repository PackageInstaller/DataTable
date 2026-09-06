local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRougeTowerOpenorNot = dataclass("SRougeTowerOpenorNot", require("framework.net.protocol"))
SRougeTowerOpenorNot.ProtocolType = 2478
SRougeTowerOpenorNot.MaxSize = 65535
SRougeTowerOpenorNot.openornot = 0
SRougeTowerOpenorNot.leftTime = 0
SRougeTowerOpenorNot.hasReward = 0

function SRougeTowerOpenorNot:Ctor(client)
  SRougeTowerOpenorNot.super.Ctor(self, client)
end

function SRougeTowerOpenorNot:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.openornot) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hasReward) then
    return false
  end
  return true
end

function SRougeTowerOpenorNot:Unmarshal(buffer)
  local ret = true
  ret, self.openornot = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.hasReward = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRougeTowerOpenorNot

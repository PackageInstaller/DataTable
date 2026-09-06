local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRequestRougeTowerOpen = dataclass("SRequestRougeTowerOpen", require("framework.net.protocol"))
SRequestRougeTowerOpen.ProtocolType = 2493
SRequestRougeTowerOpen.MaxSize = 65535
SRequestRougeTowerOpen.openornot = 0
SRequestRougeTowerOpen.leftTime = 0

function SRequestRougeTowerOpen:Ctor(client)
  SRequestRougeTowerOpen.super.Ctor(self, client)
end

function SRequestRougeTowerOpen:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.openornot) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SRequestRougeTowerOpen:Unmarshal(buffer)
  local ret = true
  ret, self.openornot = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRequestRougeTowerOpen

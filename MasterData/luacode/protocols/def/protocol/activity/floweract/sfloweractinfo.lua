local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFlowerActInfo = dataclass("SFlowerActInfo", require("framework.net.protocol"))
SFlowerActInfo.ProtocolType = 2761
SFlowerActInfo.MaxSize = 65535
SFlowerActInfo.actId = 0
SFlowerActInfo.flowerId = 0

function SFlowerActInfo:Ctor(client)
  SFlowerActInfo.super.Ctor(self, client)
end

function SFlowerActInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.actId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.flowerId) then
    return false
  end
  return true
end

function SFlowerActInfo:Unmarshal(buffer)
  local ret = true
  ret, self.actId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.flowerId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFlowerActInfo

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReduceCostActInfo = dataclass("SReduceCostActInfo", require("framework.net.protocol"))
SReduceCostActInfo.ProtocolType = 2401
SReduceCostActInfo.MaxSize = 65535
SReduceCostActInfo.endTime = 0
SReduceCostActInfo.floorList = ""
SReduceCostActInfo.discount = 0

function SReduceCostActInfo:Ctor(client)
  SReduceCostActInfo.super.Ctor(self, client)
end

function SReduceCostActInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.floorList) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolFloat(buffer, self.discount) then
    return false
  end
  return true
end

function SReduceCostActInfo:Unmarshal(buffer)
  local ret = true
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.floorList = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.discount = ProtocolBufferStaticFunctions.ReadFloat(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReduceCostActInfo

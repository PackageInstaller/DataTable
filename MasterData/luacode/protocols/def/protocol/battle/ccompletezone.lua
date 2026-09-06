local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCompleteZone = dataclass("CCompleteZone", require("framework.net.protocol"))
CCompleteZone.ProtocolType = 1957
CCompleteZone.MaxSize = 65535
CCompleteZone.floorId = 0
CCompleteZone.outPoint = 0

function CCompleteZone:Ctor(client)
  CCompleteZone.super.Ctor(self, client)
end

function CCompleteZone:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.outPoint) then
    return false
  end
  return true
end

function CCompleteZone:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.outPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteZone

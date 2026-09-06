local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CWarp2NewPoint = dataclass("CWarp2NewPoint", require("framework.net.protocol"))
CWarp2NewPoint.ProtocolType = 2417
CWarp2NewPoint.MaxSize = 65535
CWarp2NewPoint.toNextFloor = 0

function CWarp2NewPoint:Ctor(client)
  CWarp2NewPoint.super.Ctor(self, client)
end

function CWarp2NewPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.toNextFloor) then
    return false
  end
  return true
end

function CWarp2NewPoint:Unmarshal(buffer)
  local ret = true
  ret, self.toNextFloor = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CWarp2NewPoint

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnterJumpPoint = dataclass("CEnterJumpPoint", require("framework.net.protocol"))
CEnterJumpPoint.ProtocolType = 1914
CEnterJumpPoint.MaxSize = 65535
CEnterJumpPoint.id = 0
CEnterJumpPoint.outpoint = 0

function CEnterJumpPoint:Ctor(client)
  CEnterJumpPoint.super.Ctor(self, client)
end

function CEnterJumpPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.outpoint) then
    return false
  end
  return true
end

function CEnterJumpPoint:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.outpoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnterJumpPoint

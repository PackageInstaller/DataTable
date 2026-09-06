local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CArriveDeadLine = dataclass("CArriveDeadLine", require("framework.net.protocol"))
CArriveDeadLine.ProtocolType = 2332
CArriveDeadLine.MaxSize = 65535
CArriveDeadLine.positionId = 0

function CArriveDeadLine:Ctor(client)
  CArriveDeadLine.super.Ctor(self, client)
end

function CArriveDeadLine:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.positionId) then
    return false
  end
  return true
end

function CArriveDeadLine:Unmarshal(buffer)
  local ret = true
  ret, self.positionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArriveDeadLine

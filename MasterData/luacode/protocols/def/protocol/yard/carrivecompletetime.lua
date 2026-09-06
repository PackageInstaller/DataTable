local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CArriveCompleteTime = dataclass("CArriveCompleteTime", require("framework.net.protocol"))
CArriveCompleteTime.ProtocolType = 2325
CArriveCompleteTime.MaxSize = 65535
CArriveCompleteTime.id = 0

function CArriveCompleteTime:Ctor(client)
  CArriveCompleteTime.super.Ctor(self, client)
end

function CArriveCompleteTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CArriveCompleteTime:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArriveCompleteTime

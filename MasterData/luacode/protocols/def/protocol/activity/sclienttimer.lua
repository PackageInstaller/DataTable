local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCLientTimer = dataclass("SCLientTimer", require("framework.net.protocol"))
SCLientTimer.ProtocolType = 2714
SCLientTimer.MaxSize = 65535
SCLientTimer.timeId = 0
SCLientTimer.time = 0

function SCLientTimer:Ctor(client)
  SCLientTimer.super.Ctor(self, client)
end

function SCLientTimer:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.timeId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  return true
end

function SCLientTimer:Unmarshal(buffer)
  local ret = true
  ret, self.timeId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.time = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCLientTimer

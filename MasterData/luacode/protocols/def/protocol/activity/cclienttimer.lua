local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCLientTimer = dataclass("CCLientTimer", require("framework.net.protocol"))
CCLientTimer.ProtocolType = 2713
CCLientTimer.MaxSize = 65536
CCLientTimer.timeId = 0

function CCLientTimer:Ctor(client)
  CCLientTimer.super.Ctor(self, client)
end

function CCLientTimer:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.timeId) then
    return false
  end
  return true
end

function CCLientTimer:Unmarshal(buffer)
  local ret = true
  ret, self.timeId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCLientTimer

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SServerTime = dataclass("SServerTime", require("framework.net.protocol"))
SServerTime.ProtocolType = 1701
SServerTime.MaxSize = 65535
SServerTime.time = 0

function SServerTime:Ctor(client)
  SServerTime.super.Ctor(self, client)
end

function SServerTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  return true
end

function SServerTime:Unmarshal(buffer)
  local ret = true
  ret, self.time = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SServerTime

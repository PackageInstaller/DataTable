local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLightActivityRedpoint = dataclass("SLightActivityRedpoint", require("framework.net.protocol"))
SLightActivityRedpoint.ProtocolType = 2511
SLightActivityRedpoint.MaxSize = 65535
SLightActivityRedpoint.activity = 0

function SLightActivityRedpoint:Ctor(client)
  SLightActivityRedpoint.super.Ctor(self, client)
end

function SLightActivityRedpoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activity) then
    return false
  end
  return true
end

function SLightActivityRedpoint:Unmarshal(buffer)
  local ret = true
  ret, self.activity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightActivityRedpoint

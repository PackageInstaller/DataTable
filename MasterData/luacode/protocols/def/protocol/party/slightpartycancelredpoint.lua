local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLightPartyCancelRedpoint = dataclass("SLightPartyCancelRedpoint", require("framework.net.protocol"))
SLightPartyCancelRedpoint.ProtocolType = 5037
SLightPartyCancelRedpoint.MaxSize = 65535
SLightPartyCancelRedpoint.redpointType = 0

function SLightPartyCancelRedpoint:Ctor(client)
  SLightPartyCancelRedpoint.super.Ctor(self, client)
end

function SLightPartyCancelRedpoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redpointType) then
    return false
  end
  return true
end

function SLightPartyCancelRedpoint:Unmarshal(buffer)
  local ret = true
  ret, self.redpointType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightPartyCancelRedpoint

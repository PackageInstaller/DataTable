local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnter = dataclass("CEnter", require("framework.net.protocol"))
CEnter.ProtocolType = 2201
CEnter.MaxSize = 65535
CEnter.deepLink = 0

function CEnter:Ctor(client)
  CEnter.super.Ctor(self, client)
end

function CEnter:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.deepLink) then
    return false
  end
  return true
end

function CEnter:Unmarshal(buffer)
  local ret = true
  ret, self.deepLink = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnter

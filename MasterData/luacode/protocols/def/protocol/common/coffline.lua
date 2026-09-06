local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COffline = dataclass("COffline", require("framework.net.protocol"))
COffline.ProtocolType = 105
COffline.MaxSize = 256
COffline.offtype = 0

function COffline:Ctor(client)
  COffline.super.Ctor(self, client)
end

function COffline:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.offtype) then
    return false
  end
  return true
end

function COffline:Unmarshal(buffer)
  local ret = true
  ret, self.offtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COffline

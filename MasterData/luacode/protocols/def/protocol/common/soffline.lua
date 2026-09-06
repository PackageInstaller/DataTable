local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOffline = dataclass("SOffline", require("framework.net.protocol"))
SOffline.ProtocolType = 106
SOffline.MaxSize = 256
SOffline.offtype = 0
SOffline.reason = ""

function SOffline:Ctor(client)
  SOffline.super.Ctor(self, client)
end

function SOffline:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.offtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.reason) then
    return false
  end
  return true
end

function SOffline:Unmarshal(buffer)
  local ret = true
  ret, self.offtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.reason = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOffline

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenMail = dataclass("COpenMail", require("framework.net.protocol"))
COpenMail.ProtocolType = 1411
COpenMail.MaxSize = 65535
COpenMail.uniqueId = 0

function COpenMail:Ctor(client)
  COpenMail.super.Ctor(self, client)
end

function COpenMail:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  return true
end

function COpenMail:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenMail

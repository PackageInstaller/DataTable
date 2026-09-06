local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeUserName = dataclass("CChangeUserName", require("framework.net.protocol"))
CChangeUserName.ProtocolType = 2220
CChangeUserName.MaxSize = 65535
CChangeUserName.name = ""

function CChangeUserName:Ctor(client)
  CChangeUserName.super.Ctor(self, client)
end

function CChangeUserName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function CChangeUserName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserName

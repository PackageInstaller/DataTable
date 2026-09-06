local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCreateUser = dataclass("CCreateUser", require("framework.net.protocol"))
CCreateUser.ProtocolType = 2205
CCreateUser.MaxSize = 65535
CCreateUser.name = ""

function CCreateUser:Ctor(client)
  CCreateUser.super.Ctor(self, client)
end

function CCreateUser:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function CCreateUser:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCreateUser

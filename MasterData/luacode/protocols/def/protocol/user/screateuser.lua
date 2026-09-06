local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCreateUser = dataclass("SCreateUser", require("framework.net.protocol"))
SCreateUser.ProtocolType = 2206
SCreateUser.MaxSize = 65535
SCreateUser.username = ""

function SCreateUser:Ctor(client)
  SCreateUser.super.Ctor(self, client)
end

function SCreateUser:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.username) then
    return false
  end
  return true
end

function SCreateUser:Unmarshal(buffer)
  local ret = true
  ret, self.username = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCreateUser

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddUser = dataclass("SAddUser", require("framework.net.protocol"))
SAddUser.ProtocolType = 1135
SAddUser.MaxSize = 65535

function SAddUser:Ctor(client)
  SAddUser.super.Ctor(self, client)
  self.user = require("protocols.bean.protocol.chat.otheruserinfo").Create()
end

function SAddUser:Marshal(buffer)
  if not self.user:Marshal(buffer) then
    return false
  end
  return true
end

function SAddUser:Unmarshal(buffer)
  local ret = true
  if not self.user:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAddUser

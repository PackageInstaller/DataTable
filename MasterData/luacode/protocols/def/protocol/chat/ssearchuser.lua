local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSearchUser = dataclass("SSearchUser", require("framework.net.protocol"))
SSearchUser.ProtocolType = 1123
SSearchUser.MaxSize = 65535

function SSearchUser:Ctor(client)
  SSearchUser.super.Ctor(self, client)
  self.users = require("protocols.bean.protocol.chat.otheruserinfo").Create()
end

function SSearchUser:Marshal(buffer)
  if not self.users:Marshal(buffer) then
    return false
  end
  return true
end

function SSearchUser:Unmarshal(buffer)
  local ret = true
  if not self.users:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSearchUser

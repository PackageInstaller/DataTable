local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleAdd = dataclass("SRoleAdd", require("framework.net.protocol"))
SRoleAdd.ProtocolType = 1012
SRoleAdd.MaxSize = 65535

function SRoleAdd:Ctor(client)
  SRoleAdd.super.Ctor(self, client)
  self.role = require("protocols.bean.protocol.login.role").Create()
end

function SRoleAdd:Marshal(buffer)
  if not self.role:Marshal(buffer) then
    return false
  end
  return true
end

function SRoleAdd:Unmarshal(buffer)
  local ret = true
  if not self.role:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRoleAdd

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SupportRole = dataclass("SupportRole")

function SupportRole:Ctor()
  self.role = require("protocols.bean.protocol.login.role").Create()
  self.user = require("protocols.bean.protocol.chat.otheruserinfo").Create()
end

function SupportRole:Marshal(buffer)
  if not self.role:Marshal(buffer) then
    return false
  end
  if not self.user:Marshal(buffer) then
    return false
  end
  return true
end

function SupportRole:Unmarshal(buffer)
  local ret = true
  if not self.role:Unmarshal(buffer) then
    return false
  end
  if not self.user:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SupportRole

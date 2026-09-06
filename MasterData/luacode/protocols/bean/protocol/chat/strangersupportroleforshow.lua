local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local StrangerSupportRoleForShow = dataclass("StrangerSupportRoleForShow")

function StrangerSupportRoleForShow:Ctor()
  self.roleInfo = require("protocols.bean.protocol.chat.supportroleforshow").Create()
  self.userInfo = require("protocols.bean.protocol.chat.otheruserinfo").Create()
end

function StrangerSupportRoleForShow:Marshal(buffer)
  if not self.roleInfo:Marshal(buffer) then
    return false
  end
  if not self.userInfo:Marshal(buffer) then
    return false
  end
  return true
end

function StrangerSupportRoleForShow:Unmarshal(buffer)
  local ret = true
  if not self.roleInfo:Unmarshal(buffer) then
    return false
  end
  if not self.userInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return StrangerSupportRoleForShow

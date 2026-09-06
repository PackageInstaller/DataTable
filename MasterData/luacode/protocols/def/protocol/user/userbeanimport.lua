local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local UserBeanImport = dataclass("UserBeanImport", require("framework.net.protocol"))
UserBeanImport.ProtocolType = 2010
UserBeanImport.MaxSize = 65535

function UserBeanImport:Ctor(client)
  UserBeanImport.super.Ctor(self, client)
  self.guideTypes = require("protocols.bean.protocol.user.guidtypes").Create()
  self.sysConfig = require("protocols.bean.protocol.user.sysconfig").Create()
  self.bookType = require("protocols.bean.protocol.user.handbooktype").Create()
end

function UserBeanImport:Marshal(buffer)
  if not self.guideTypes:Marshal(buffer) then
    return false
  end
  if not self.sysConfig:Marshal(buffer) then
    return false
  end
  if not self.bookType:Marshal(buffer) then
    return false
  end
  return true
end

function UserBeanImport:Unmarshal(buffer)
  local ret = true
  if not self.guideTypes:Unmarshal(buffer) then
    return false
  end
  if not self.sysConfig:Unmarshal(buffer) then
    return false
  end
  if not self.bookType:Unmarshal(buffer) then
    return false
  end
  return ret
end

return UserBeanImport

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Common = dataclass("Common", require("framework.net.protocol"))
Common.ProtocolType = 99
Common.MaxSize = 256

function Common:Ctor(client)
  Common.super.Ctor(self, client)
  self.b1 = require("protocols.bean.protocol.common.systemtype").Create()
  self.b2 = require("protocols.bean.protocol.common.offlinetype").Create()
  self.b3 = require("protocols.bean.protocol.common.commonawardstatus").Create()
end

function Common:Marshal(buffer)
  if not self.b1:Marshal(buffer) then
    return false
  end
  if not self.b2:Marshal(buffer) then
    return false
  end
  if not self.b3:Marshal(buffer) then
    return false
  end
  return true
end

function Common:Unmarshal(buffer)
  local ret = true
  if not self.b1:Unmarshal(buffer) then
    return false
  end
  if not self.b2:Unmarshal(buffer) then
    return false
  end
  if not self.b3:Unmarshal(buffer) then
    return false
  end
  return ret
end

return Common

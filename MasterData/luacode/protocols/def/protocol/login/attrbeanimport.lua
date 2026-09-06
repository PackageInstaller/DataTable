local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local AttrBeanImport = dataclass("AttrBeanImport", require("framework.net.protocol"))
AttrBeanImport.ProtocolType = 1100
AttrBeanImport.MaxSize = 65535

function AttrBeanImport:Ctor(client)
  AttrBeanImport.super.Ctor(self, client)
  self.b1 = require("protocols.bean.protocol.login.attrtype").Create()
  self.b2 = require("protocols.bean.protocol.login.effecttype").Create()
  self.b3 = require("protocols.bean.protocol.login.lineupstation").Create()
  self.b4 = require("protocols.bean.protocol.login.buffstate").Create()
end

function AttrBeanImport:Marshal(buffer)
  if not self.b1:Marshal(buffer) then
    return false
  end
  if not self.b2:Marshal(buffer) then
    return false
  end
  if not self.b3:Marshal(buffer) then
    return false
  end
  if not self.b4:Marshal(buffer) then
    return false
  end
  return true
end

function AttrBeanImport:Unmarshal(buffer)
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
  if not self.b4:Unmarshal(buffer) then
    return false
  end
  return ret
end

return AttrBeanImport

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLookCardBaseAttr = dataclass("SLookCardBaseAttr", require("framework.net.protocol"))
SLookCardBaseAttr.ProtocolType = 1526
SLookCardBaseAttr.MaxSize = 65535

function SLookCardBaseAttr:Ctor(client)
  SLookCardBaseAttr.super.Ctor(self, client)
  self.role = require("protocols.bean.protocol.card.role").Create()
end

function SLookCardBaseAttr:Marshal(buffer)
  if not self.role:Marshal(buffer) then
    return false
  end
  return true
end

function SLookCardBaseAttr:Unmarshal(buffer)
  local ret = true
  if not self.role:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLookCardBaseAttr

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDestroyPoint = dataclass("SDestroyPoint", require("framework.net.protocol"))
SDestroyPoint.ProtocolType = 1937
SDestroyPoint.MaxSize = 65535

function SDestroyPoint:Ctor(client)
  SDestroyPoint.super.Ctor(self, client)
  self.specialPoint = require("protocols.bean.protocol.battle.point").Create()
end

function SDestroyPoint:Marshal(buffer)
  if not self.specialPoint:Marshal(buffer) then
    return false
  end
  return true
end

function SDestroyPoint:Unmarshal(buffer)
  local ret = true
  if not self.specialPoint:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SDestroyPoint

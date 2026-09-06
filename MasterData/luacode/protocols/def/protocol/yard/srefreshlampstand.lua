local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshLampStand = dataclass("SRefreshLampStand", require("framework.net.protocol"))
SRefreshLampStand.ProtocolType = 2336
SRefreshLampStand.MaxSize = 65535

function SRefreshLampStand:Ctor(client)
  SRefreshLampStand.super.Ctor(self, client)
  self.lampStand = require("protocols.bean.protocol.yard.lampstand").Create()
end

function SRefreshLampStand:Marshal(buffer)
  if not self.lampStand:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshLampStand:Unmarshal(buffer)
  local ret = true
  if not self.lampStand:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshLampStand

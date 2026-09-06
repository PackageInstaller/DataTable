local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshFloor = dataclass("SRefreshFloor", require("framework.net.protocol"))
SRefreshFloor.ProtocolType = 2368
SRefreshFloor.MaxSize = 65535

function SRefreshFloor:Ctor(client)
  SRefreshFloor.super.Ctor(self, client)
  self.floor = require("protocols.bean.protocol.yard.witchfloor").Create()
end

function SRefreshFloor:Marshal(buffer)
  if not self.floor:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshFloor:Unmarshal(buffer)
  local ret = true
  if not self.floor:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshFloor

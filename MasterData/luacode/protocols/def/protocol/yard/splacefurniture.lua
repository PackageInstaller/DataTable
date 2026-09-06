local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPlaceFurniture = dataclass("SPlaceFurniture", require("framework.net.protocol"))
SPlaceFurniture.ProtocolType = 2360
SPlaceFurniture.MaxSize = 65535

function SPlaceFurniture:Ctor(client)
  SPlaceFurniture.super.Ctor(self, client)
  self.floor = require("protocols.bean.protocol.yard.witchfloor").Create()
end

function SPlaceFurniture:Marshal(buffer)
  if not self.floor:Marshal(buffer) then
    return false
  end
  return true
end

function SPlaceFurniture:Unmarshal(buffer)
  local ret = true
  if not self.floor:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SPlaceFurniture

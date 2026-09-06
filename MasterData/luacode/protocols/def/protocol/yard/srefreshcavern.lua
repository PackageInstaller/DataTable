local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshCavern = dataclass("SRefreshCavern", require("framework.net.protocol"))
SRefreshCavern.ProtocolType = 2321
SRefreshCavern.MaxSize = 65535

function SRefreshCavern:Ctor(client)
  SRefreshCavern.super.Ctor(self, client)
  self.cavern = require("protocols.bean.protocol.yard.cavern").Create()
end

function SRefreshCavern:Marshal(buffer)
  if not self.cavern:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshCavern:Unmarshal(buffer)
  local ret = true
  if not self.cavern:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshCavern

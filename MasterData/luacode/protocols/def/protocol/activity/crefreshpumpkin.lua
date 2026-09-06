local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshPumpkin = dataclass("CRefreshPumpkin", require("framework.net.protocol"))
CRefreshPumpkin.ProtocolType = 2518
CRefreshPumpkin.MaxSize = 65535

function CRefreshPumpkin:Ctor(client)
  CRefreshPumpkin.super.Ctor(self, client)
end

function CRefreshPumpkin:Marshal(buffer)
  return true
end

function CRefreshPumpkin:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshPumpkin

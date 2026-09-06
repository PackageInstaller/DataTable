local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenShop = dataclass("COpenShop", require("framework.net.protocol"))
COpenShop.ProtocolType = 3616
COpenShop.MaxSize = 65535

function COpenShop:Ctor(client)
  COpenShop.super.Ctor(self, client)
end

function COpenShop:Marshal(buffer)
  return true
end

function COpenShop:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenShop

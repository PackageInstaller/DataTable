local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshShopHomepage = dataclass("CRefreshShopHomepage", require("framework.net.protocol"))
CRefreshShopHomepage.ProtocolType = 3628
CRefreshShopHomepage.MaxSize = 65535

function CRefreshShopHomepage:Ctor(client)
  CRefreshShopHomepage.super.Ctor(self, client)
end

function CRefreshShopHomepage:Marshal(buffer)
  return true
end

function CRefreshShopHomepage:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshShopHomepage

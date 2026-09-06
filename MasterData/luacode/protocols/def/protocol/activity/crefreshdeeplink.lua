local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshDeepLink = dataclass("CRefreshDeepLink", require("framework.net.protocol"))
CRefreshDeepLink.ProtocolType = 2519
CRefreshDeepLink.MaxSize = 65535

function CRefreshDeepLink:Ctor(client)
  CRefreshDeepLink.super.Ctor(self, client)
end

function CRefreshDeepLink:Marshal(buffer)
  return true
end

function CRefreshDeepLink:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshDeepLink

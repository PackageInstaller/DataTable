local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDeepLinkActivity = dataclass("SOpenDeepLinkActivity", require("framework.net.protocol"))
SOpenDeepLinkActivity.ProtocolType = 2512
SOpenDeepLinkActivity.MaxSize = 65535

function SOpenDeepLinkActivity:Ctor(client)
  SOpenDeepLinkActivity.super.Ctor(self, client)
end

function SOpenDeepLinkActivity:Marshal(buffer)
  return true
end

function SOpenDeepLinkActivity:Unmarshal(buffer)
  local ret = true
  return ret
end

return SOpenDeepLinkActivity

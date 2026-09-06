local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenBackGift = dataclass("COpenBackGift", require("framework.net.protocol"))
COpenBackGift.ProtocolType = 2553
COpenBackGift.MaxSize = 65535

function COpenBackGift:Ctor(client)
  COpenBackGift.super.Ctor(self, client)
end

function COpenBackGift:Marshal(buffer)
  return true
end

function COpenBackGift:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenBackGift

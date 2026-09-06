local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshBackGift = dataclass("SRefreshBackGift", require("framework.net.protocol"))
SRefreshBackGift.ProtocolType = 2598
SRefreshBackGift.MaxSize = 65535

function SRefreshBackGift:Ctor(client)
  SRefreshBackGift.super.Ctor(self, client)
end

function SRefreshBackGift:Marshal(buffer)
  return true
end

function SRefreshBackGift:Unmarshal(buffer)
  local ret = true
  return ret
end

return SRefreshBackGift

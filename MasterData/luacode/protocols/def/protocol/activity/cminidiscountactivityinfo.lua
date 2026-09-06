local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMiniDiscountActivityInfo = dataclass("CMiniDiscountActivityInfo", require("framework.net.protocol"))
CMiniDiscountActivityInfo.ProtocolType = 2747
CMiniDiscountActivityInfo.MaxSize = 65535

function CMiniDiscountActivityInfo:Ctor(client)
  CMiniDiscountActivityInfo.super.Ctor(self, client)
end

function CMiniDiscountActivityInfo:Marshal(buffer)
  return true
end

function CMiniDiscountActivityInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CMiniDiscountActivityInfo

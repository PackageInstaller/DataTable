local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEchoShopRedPoint = dataclass("SEchoShopRedPoint", require("framework.net.protocol"))
SEchoShopRedPoint.ProtocolType = 2711
SEchoShopRedPoint.MaxSize = 65535

function SEchoShopRedPoint:Ctor(client)
  SEchoShopRedPoint.super.Ctor(self, client)
end

function SEchoShopRedPoint:Marshal(buffer)
  return true
end

function SEchoShopRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SEchoShopRedPoint

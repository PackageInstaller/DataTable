local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBackGiftRedPoint = dataclass("SBackGiftRedPoint", require("framework.net.protocol"))
SBackGiftRedPoint.ProtocolType = 2574
SBackGiftRedPoint.MaxSize = 65535

function SBackGiftRedPoint:Ctor(client)
  SBackGiftRedPoint.super.Ctor(self, client)
end

function SBackGiftRedPoint:Marshal(buffer)
  return true
end

function SBackGiftRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SBackGiftRedPoint

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFitstRechargeGiftRedPoint = dataclass("SFitstRechargeGiftRedPoint", require("framework.net.protocol"))
SFitstRechargeGiftRedPoint.ProtocolType = 3632
SFitstRechargeGiftRedPoint.MaxSize = 65535

function SFitstRechargeGiftRedPoint:Ctor(client)
  SFitstRechargeGiftRedPoint.super.Ctor(self, client)
end

function SFitstRechargeGiftRedPoint:Marshal(buffer)
  return true
end

function SFitstRechargeGiftRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SFitstRechargeGiftRedPoint

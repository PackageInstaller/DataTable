local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSevenPopGiftStatus = dataclass("SSevenPopGiftStatus", require("framework.net.protocol"))
SSevenPopGiftStatus.ProtocolType = 2746
SSevenPopGiftStatus.MaxSize = 65535
SSevenPopGiftStatus.leftTime = 0

function SSevenPopGiftStatus:Ctor(client)
  SSevenPopGiftStatus.super.Ctor(self, client)
end

function SSevenPopGiftStatus:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SSevenPopGiftStatus:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenPopGiftStatus

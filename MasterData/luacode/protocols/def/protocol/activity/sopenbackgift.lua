local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenBackGift = dataclass("SOpenBackGift", require("framework.net.protocol"))
SOpenBackGift.ProtocolType = 2554
SOpenBackGift.MaxSize = 65535
SOpenBackGift.leftTime = 0

function SOpenBackGift:Ctor(client)
  SOpenBackGift.super.Ctor(self, client)
  self.goodInfo = require("protocols.bean.protocol.activity.goodinfo").Create()
end

function SOpenBackGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not self.goodInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SOpenBackGift:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  if not self.goodInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenBackGift

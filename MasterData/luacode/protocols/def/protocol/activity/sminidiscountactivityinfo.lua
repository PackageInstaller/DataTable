local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMiniDiscountActivityInfo = dataclass("SMiniDiscountActivityInfo", require("framework.net.protocol"))
SMiniDiscountActivityInfo.ProtocolType = 2748
SMiniDiscountActivityInfo.MaxSize = 65535
SMiniDiscountActivityInfo.id = 0
SMiniDiscountActivityInfo.leftTime = 0
SMiniDiscountActivityInfo.redDot = 0

function SMiniDiscountActivityInfo:Ctor(client)
  SMiniDiscountActivityInfo.super.Ctor(self, client)
  self.goodInfo = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
end

function SMiniDiscountActivityInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not self.goodInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redDot) then
    return false
  end
  return true
end

function SMiniDiscountActivityInfo:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.goodInfo:Unmarshal(buffer) then
    return false
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.redDot = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SMiniDiscountActivityInfo

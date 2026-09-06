local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetFirstRechargeGift = dataclass("CGetFirstRechargeGift", require("framework.net.protocol"))
CGetFirstRechargeGift.ProtocolType = 3631
CGetFirstRechargeGift.MaxSize = 65535
CGetFirstRechargeGift.gainGiftID = 0

function CGetFirstRechargeGift:Ctor(client)
  CGetFirstRechargeGift.super.Ctor(self, client)
end

function CGetFirstRechargeGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gainGiftID) then
    return false
  end
  return true
end

function CGetFirstRechargeGift:Unmarshal(buffer)
  local ret = true
  ret, self.gainGiftID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetFirstRechargeGift

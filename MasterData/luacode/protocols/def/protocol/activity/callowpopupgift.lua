local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAllowPopUpGift = dataclass("CAllowPopUpGift", require("framework.net.protocol"))
CAllowPopUpGift.ProtocolType = 2690
CAllowPopUpGift.MaxSize = 65535
CAllowPopUpGift.activityID = 0

function CAllowPopUpGift:Ctor(client)
  CAllowPopUpGift.super.Ctor(self, client)
end

function CAllowPopUpGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function CAllowPopUpGift:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAllowPopUpGift

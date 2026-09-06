local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAllowPopUpGift = dataclass("SAllowPopUpGift", require("framework.net.protocol"))
SAllowPopUpGift.ProtocolType = 2689
SAllowPopUpGift.MaxSize = 65535
SAllowPopUpGift.activityID = 0

function SAllowPopUpGift:Ctor(client)
  SAllowPopUpGift.super.Ctor(self, client)
end

function SAllowPopUpGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function SAllowPopUpGift:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAllowPopUpGift

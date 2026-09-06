local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActivityShopRedDot = dataclass("SActivityShopRedDot", require("framework.net.protocol"))
SActivityShopRedDot.ProtocolType = 2730
SActivityShopRedDot.MaxSize = 65535
SActivityShopRedDot.activityId = 0

function SActivityShopRedDot:Ctor(client)
  SActivityShopRedDot.super.Ctor(self, client)
end

function SActivityShopRedDot:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function SActivityShopRedDot:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SActivityShopRedDot

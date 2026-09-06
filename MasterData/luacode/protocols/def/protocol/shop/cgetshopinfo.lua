local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetShopInfo = dataclass("CGetShopInfo", require("framework.net.protocol"))
CGetShopInfo.ProtocolType = 3611
CGetShopInfo.MaxSize = 65535
CGetShopInfo.shopId = 0

function CGetShopInfo:Ctor(client)
  CGetShopInfo.super.Ctor(self, client)
end

function CGetShopInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  return true
end

function CGetShopInfo:Unmarshal(buffer)
  local ret = true
  ret, self.shopId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetShopInfo

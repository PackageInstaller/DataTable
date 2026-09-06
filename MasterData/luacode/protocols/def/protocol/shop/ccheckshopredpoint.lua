local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckShopRedpoint = dataclass("CCheckShopRedpoint", require("framework.net.protocol"))
CCheckShopRedpoint.ProtocolType = 3639
CCheckShopRedpoint.MaxSize = 65535
CCheckShopRedpoint.shoptype = 0
CCheckShopRedpoint.goodId = 0

function CCheckShopRedpoint:Ctor(client)
  CCheckShopRedpoint.super.Ctor(self, client)
end

function CCheckShopRedpoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shoptype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function CCheckShopRedpoint:Unmarshal(buffer)
  local ret = true
  ret, self.shoptype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckShopRedpoint

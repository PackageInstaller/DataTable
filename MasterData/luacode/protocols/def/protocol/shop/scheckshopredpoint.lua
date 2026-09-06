local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckShopRedpoint = dataclass("SCheckShopRedpoint", require("framework.net.protocol"))
SCheckShopRedpoint.ProtocolType = 3640
SCheckShopRedpoint.MaxSize = 65535
SCheckShopRedpoint.shoptype = 0
SCheckShopRedpoint.goodId = 0
SCheckShopRedpoint.canDo = 0

function SCheckShopRedpoint:Ctor(client)
  SCheckShopRedpoint.super.Ctor(self, client)
end

function SCheckShopRedpoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shoptype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canDo) then
    return false
  end
  return true
end

function SCheckShopRedpoint:Unmarshal(buffer)
  local ret = true
  ret, self.shoptype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.canDo = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckShopRedpoint

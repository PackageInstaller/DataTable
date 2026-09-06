local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendSpringShopActivity = dataclass("SSendSpringShopActivity", require("framework.net.protocol"))
SSendSpringShopActivity.ProtocolType = 2615
SSendSpringShopActivity.MaxSize = 65535
SSendSpringShopActivity.state = 0

function SSendSpringShopActivity:Ctor(client)
  SSendSpringShopActivity.super.Ctor(self, client)
end

function SSendSpringShopActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SSendSpringShopActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendSpringShopActivity

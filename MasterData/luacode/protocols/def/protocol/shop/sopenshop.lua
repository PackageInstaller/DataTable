local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenShop = dataclass("SOpenShop", require("framework.net.protocol"))
SOpenShop.ProtocolType = 3615
SOpenShop.MaxSize = 65535

function SOpenShop:Ctor(client)
  SOpenShop.super.Ctor(self, client)
  self.shopInfo = {}
end

function SOpenShop:Marshal(buffer)
  local length = table.slen(self.shopInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.shopInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenShop:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.shopInfo[i] = require("protocols.bean.protocol.shop.shopinfo").Create()
    if not self.shopInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenShop

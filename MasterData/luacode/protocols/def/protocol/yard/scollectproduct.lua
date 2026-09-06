local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCollectProduct = dataclass("SCollectProduct", require("framework.net.protocol"))
SCollectProduct.ProtocolType = 2347
SCollectProduct.MaxSize = 65535

function SCollectProduct:Ctor(client)
  SCollectProduct.super.Ctor(self, client)
  self.items = {}
end

function SCollectProduct:Marshal(buffer)
  local length = table.slen(self.items)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.items[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCollectProduct:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.items[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.items[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCollectProduct

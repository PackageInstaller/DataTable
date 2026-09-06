local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSureDrawTenCard = dataclass("SSureDrawTenCard", require("framework.net.protocol"))
SSureDrawTenCard.ProtocolType = 1525
SSureDrawTenCard.MaxSize = 65535

function SSureDrawTenCard:Ctor(client)
  SSureDrawTenCard.super.Ctor(self, client)
  self.items = {}
end

function SSureDrawTenCard:Marshal(buffer)
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

function SSureDrawTenCard:Unmarshal(buffer)
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

return SSureDrawTenCard

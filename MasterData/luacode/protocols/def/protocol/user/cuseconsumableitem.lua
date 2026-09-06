local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUseConsumableItem = dataclass("CUseConsumableItem", require("framework.net.protocol"))
CUseConsumableItem.ProtocolType = 2267
CUseConsumableItem.MaxSize = 65535

function CUseConsumableItem:Ctor(client)
  CUseConsumableItem.super.Ctor(self, client)
  self.itemIds = {}
end

function CUseConsumableItem:Marshal(buffer)
  local length = table.slen(self.itemIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemIds[i]) then
      return false
    end
  end
  return true
end

function CUseConsumableItem:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.itemIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CUseConsumableItem

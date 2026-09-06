local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRemoveItem = dataclass("SRemoveItem", require("framework.net.protocol"))
SRemoveItem.ProtocolType = 1203
SRemoveItem.MaxSize = 65535
SRemoveItem.bagType = 0
SRemoveItem.itemKey = 0

function SRemoveItem:Ctor(client)
  SRemoveItem.super.Ctor(self, client)
end

function SRemoveItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bagType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemKey) then
    return false
  end
  return true
end

function SRemoveItem:Unmarshal(buffer)
  local ret = true
  ret, self.bagType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRemoveItem

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpdateLimitedItems = dataclass("CUpdateLimitedItems", require("framework.net.protocol"))
CUpdateLimitedItems.ProtocolType = 1245
CUpdateLimitedItems.MaxSize = 65535
CUpdateLimitedItems.itemKey = 0
CUpdateLimitedItems.itemId = 0

function CUpdateLimitedItems:Ctor(client)
  CUpdateLimitedItems.super.Ctor(self, client)
end

function CUpdateLimitedItems:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  return true
end

function CUpdateLimitedItems:Unmarshal(buffer)
  local ret = true
  ret, self.itemKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUpdateLimitedItems

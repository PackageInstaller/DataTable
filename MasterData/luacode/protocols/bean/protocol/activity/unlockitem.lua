local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local unlockItem = dataclass("unlockItem")
unlockItem.itemId = 0
unlockItem.itemNum = 0

function unlockItem:Ctor()
end

function unlockItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  return true
end

function unlockItem:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return unlockItem

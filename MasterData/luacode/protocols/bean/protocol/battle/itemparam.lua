local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ItemParam = dataclass("ItemParam")
ItemParam.itemid = 0
ItemParam.itemnum = 0

function ItemParam:Ctor()
end

function ItemParam:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemnum) then
    return false
  end
  return true
end

function ItemParam:Unmarshal(buffer)
  local ret = true
  ret, self.itemid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemnum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ItemParam

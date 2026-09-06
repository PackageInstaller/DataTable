local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ItemInfo = dataclass("ItemInfo")
ItemInfo.gain = 0
ItemInfo.id = 0
ItemInfo.itemtype = 0
ItemInfo.bagtype = 0
ItemInfo.number = 0

function ItemInfo:Ctor()
  self.delTime = {}
end

function ItemInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gain) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bagtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.number) then
    return false
  end
  local length = table.slen(self.delTime)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.delTime[i]) then
      return false
    end
  end
  return true
end

function ItemInfo:Unmarshal(buffer)
  local ret = true
  ret, self.gain = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bagtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.number = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.delTime[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return ItemInfo

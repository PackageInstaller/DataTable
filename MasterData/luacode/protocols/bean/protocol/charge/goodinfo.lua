local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local GoodInfo = dataclass("GoodInfo")
GoodInfo.goodid = 0
GoodInfo.price = 0
GoodInfo.goodtype = 0
GoodInfo.magatama = 0
GoodInfo.present = 0
GoodInfo.show = 0
GoodInfo.leftday = 0

function GoodInfo:Ctor()
end

function GoodInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.magatama) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.present) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.show) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftday) then
    return false
  end
  return true
end

function GoodInfo:Unmarshal(buffer)
  local ret = true
  ret, self.goodid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.magatama = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.present = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.show = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftday = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodInfo

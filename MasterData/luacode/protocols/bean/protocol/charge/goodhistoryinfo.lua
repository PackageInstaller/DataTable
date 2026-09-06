local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local GoodHistoryInfo = dataclass("GoodHistoryInfo")
GoodHistoryInfo.sn = 0
GoodHistoryInfo.status = 0
GoodHistoryInfo.price = 0
GoodHistoryInfo.obtainedDiamond = 0
GoodHistoryInfo.bonusDiamond = 0
GoodHistoryInfo.createtime = 0

function GoodHistoryInfo:Ctor()
end

function GoodHistoryInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.sn) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.obtainedDiamond) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bonusDiamond) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.createtime) then
    return false
  end
  return true
end

function GoodHistoryInfo:Unmarshal(buffer)
  local ret = true
  ret, self.sn = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.obtainedDiamond = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bonusDiamond = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.createtime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodHistoryInfo

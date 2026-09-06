local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ExploreAwardRecord = dataclass("ExploreAwardRecord")
ExploreAwardRecord.id = 0
ExploreAwardRecord.key = 0
ExploreAwardRecord.num = 0
ExploreAwardRecord.way = 0
ExploreAwardRecord.BOX = 1
ExploreAwardRecord.BATTLE = 2
ExploreAwardRecord.TASK = 3
ExploreAwardRecord.GROUND = 4

function ExploreAwardRecord:Ctor()
end

function ExploreAwardRecord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.way) then
    return false
  end
  return true
end

function ExploreAwardRecord:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.way = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ExploreAwardRecord

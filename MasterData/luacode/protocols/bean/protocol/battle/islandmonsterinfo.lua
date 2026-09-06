local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local IslandMonsterInfo = dataclass("IslandMonsterInfo")
IslandMonsterInfo.monserid = 0
IslandMonsterInfo.hppercent = 0

function IslandMonsterInfo:Ctor()
end

function IslandMonsterInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.monserid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hppercent) then
    return false
  end
  return true
end

function IslandMonsterInfo:Unmarshal(buffer)
  local ret = true
  ret, self.monserid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.hppercent = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return IslandMonsterInfo

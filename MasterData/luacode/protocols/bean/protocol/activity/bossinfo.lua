local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BossInfo = dataclass("BossInfo")
BossInfo.bossID = 0
BossInfo.result = 0
BossInfo.bassPassExpRewards = 0

function BossInfo:Ctor()
end

function BossInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bassPassExpRewards) then
    return false
  end
  return true
end

function BossInfo:Unmarshal(buffer)
  local ret = true
  ret, self.bossID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bassPassExpRewards = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BossInfo

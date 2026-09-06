local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BattleInfo = dataclass("BattleInfo")
BattleInfo.battleId = 0
BattleInfo.score = 0
BattleInfo.battleTimes = 0

function BattleInfo:Ctor()
end

function BattleInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleTimes) then
    return false
  end
  return true
end

function BattleInfo:Unmarshal(buffer)
  local ret = true
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BattleInfo

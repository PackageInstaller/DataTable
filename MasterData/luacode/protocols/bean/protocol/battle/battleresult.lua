local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BattleResult = dataclass("BattleResult")
BattleResult.battleId = 0
BattleResult.result = 0
BattleResult.failTime = 0
BattleResult.resourceFirstWin = 0
BattleResult.FAILED = 0
BattleResult.SUCCESS = 1
BattleResult.SETTLE = 2

function BattleResult:Ctor()
end

function BattleResult:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.failTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resourceFirstWin) then
    return false
  end
  return true
end

function BattleResult:Unmarshal(buffer)
  local ret = true
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.failTime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.resourceFirstWin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BattleResult

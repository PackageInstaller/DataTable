local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictBattleResult = dataclass("SFantasyConflictBattleResult", require("framework.net.protocol"))
SFantasyConflictBattleResult.ProtocolType = 4160
SFantasyConflictBattleResult.MaxSize = 65535
SFantasyConflictBattleResult.result = 0
SFantasyConflictBattleResult.getPoint = 0
SFantasyConflictBattleResult.seasonId = 0
SFantasyConflictBattleResult.currentScore = 0
SFantasyConflictBattleResult.stage = 0
SFantasyConflictBattleResult.leftEnterTimes = 0
SFantasyConflictBattleResult.leftAttackAccessPoint = 0
SFantasyConflictBattleResult.leftDefendAccessPoint = 0
SFantasyConflictBattleResult.leftDefendLosePoint = 0
SFantasyConflictBattleResult.leftTime = 0

function SFantasyConflictBattleResult:Ctor(client)
  SFantasyConflictBattleResult.super.Ctor(self, client)
  self.enemyInfo = {}
end

function SFantasyConflictBattleResult:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.getPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftEnterTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftAttackAccessPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftDefendAccessPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftDefendLosePoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.enemyInfo)) then
    return false
  end
  for key, value in pairs(self.enemyInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SFantasyConflictBattleResult:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.getPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.currentScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftEnterTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftAttackAccessPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftDefendAccessPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftDefendLosePoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.battle.fantasyconflictenemylineup").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.enemyInfo[key] = value
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFantasyConflictBattleResult

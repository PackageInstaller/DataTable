-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfantasyconflictbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
SFantasyConflictBattleResult.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFantasyConflictBattleResult
  ((SFantasyConflictBattleResult.super).Ctor)(self, client)
  self.enemyInfo = {}
end

SFantasyConflictBattleResult.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.getPoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.seasonId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentScore) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftEnterTimes) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftAttackAccessPoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftDefendAccessPoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftDefendLosePoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.enemyInfo)) then
    return false
  end
  for key,value in pairs(self.enemyInfo) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC90) then
      return false
    end
    if not value:Marshal(R9_PC90) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  return true
end

SFantasyConflictBattleResult.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC103: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.enemyInfo)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFantasyConflictBattleResult


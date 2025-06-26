-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfantasyconflictopenpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFantasyConflictOpenPanel = dataclass("SFantasyConflictOpenPanel", require("framework.net.protocol"))
SFantasyConflictOpenPanel.ProtocolType = 4150
SFantasyConflictOpenPanel.MaxSize = 65535
SFantasyConflictOpenPanel.waiting = 0
SFantasyConflictOpenPanel.seasonId = 0
SFantasyConflictOpenPanel.currentScore = 0
SFantasyConflictOpenPanel.stage = 0
SFantasyConflictOpenPanel.leftEnterTimes = 0
SFantasyConflictOpenPanel.leftAttackAccessPoint = 0
SFantasyConflictOpenPanel.leftDefendAccessPoint = 0
SFantasyConflictOpenPanel.leftDefendLosePoint = 0
SFantasyConflictOpenPanel.leftTime = 0
SFantasyConflictOpenPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFantasyConflictOpenPanel
  ((SFantasyConflictOpenPanel.super).Ctor)(self, client)
  self.enemyInfo = {}
  self.attackTeam = {}
  self.defendTeam = {}
end

SFantasyConflictOpenPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.waiting) then
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
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC82) then
      return false
    end
    if not value:Marshal(R9_PC82) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.attackTeam)) then
    return false
  end
  for key,value in pairs(self.attackTeam) do
    -- DECOMPILER ERROR at PC121: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC82) then
      return false
    end
    -- DECOMPILER ERROR at PC129: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC82) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.defendTeam)) then
    return false
  end
  for key,value in pairs(self.defendTeam) do
    -- DECOMPILER ERROR at PC154: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC82) then
      return false
    end
    -- DECOMPILER ERROR at PC162: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC82) then
      return false
    end
  end
  return true
end

SFantasyConflictOpenPanel.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC95: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC104: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.enemyInfo)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC142: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC148: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.attackTeam)[key] = value
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
    -- DECOMPILER ERROR at PC178: Overwrote pending register: R11 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC184: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (self.defendTeam)[key] = value
  end
  return ret
end

return SFantasyConflictOpenPanel


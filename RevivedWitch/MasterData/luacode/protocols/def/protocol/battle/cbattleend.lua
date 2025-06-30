-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBattleEnd = dataclass("CBattleEnd", require("framework.net.protocol"))
CBattleEnd.ProtocolType = 1903
CBattleEnd.MaxSize = 655350
CBattleEnd.battletype = 0
CBattleEnd.id = 0
CBattleEnd.result = 0
CBattleEnd.isAssisted = 0
CBattleEnd.stepNum = 0
CBattleEnd.reconnection = 0
CBattleEnd.interrupt = 0
CBattleEnd.totalDamage = 0
CBattleEnd.BATTLE_SUCCESS_SKIP = 5
CBattleEnd.BATTLE_SUCCESS_TIMEOUT = 3
CBattleEnd.BATTLE_SUCCESS_GM = 2
CBattleEnd.BATTLE_SUCCESS = 1
CBattleEnd.BATTLE_SETTLE = 4
CBattleEnd.BATTLE_FAIL = 11
CBattleEnd.BATTLE_RETREAT = 12
CBattleEnd.BATTLE_FAIL_TIMEOUT = 13
CBattleEnd.BATTLE_FAIL_GM = 14
CBattleEnd.BATTLE_TIE = 15
CBattleEnd.Lua_Code_Version = 1
CBattleEnd.Battle_Data_Version = 2
CBattleEnd.Behavior_Version = 3
CBattleEnd.Dungeon_Data_Version = 4
CBattleEnd.Excel_Data_Version = 5
CBattleEnd.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBattleEnd, _ENV
  ((CBattleEnd.super).Ctor)(self, client)
  self.statuses = {}
  self.enemyStatuses = {}
  self.operate = ((require("protocols.bean.protocol.battle.verifyinfolistbean")).Create)()
  self.auto = ((require("protocols.bean.protocol.battle.autofightskills")).Create)()
  self.skills = {}
  self.killMonsterNum = {}
  self.skillinfo = {}
  self.versions = {}
end

CBattleEnd.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battletype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.statuses)) then
    return false
  end
  for key,value in pairs(self.statuses) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not value:Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.enemyStatuses)) then
    return false
  end
  for key,value in pairs(self.enemyStatuses) do
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    -- DECOMPILER ERROR at PC80: Overwrote pending register: R9 in 'AssignReg'

    if not value:Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isAssisted) then
    return false
  end
  if not (self.operate):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stepNum) then
    return false
  end
  if not (self.auto):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.skills)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC139: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.skills)[i]):Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.killMonsterNum)) then
    return false
  end
  for key,value in pairs(self.killMonsterNum) do
    -- DECOMPILER ERROR at PC162: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC42, R10_PC164) then
      return false
    end
    -- DECOMPILER ERROR at PC170: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC42, R10_PC164) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.skillinfo)) then
    return false
  end
  for key,value in pairs(self.skillinfo) do
    -- DECOMPILER ERROR at PC195: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC196: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC42, R10_PC164) then
      return false
    end
    -- DECOMPILER ERROR at PC203: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC204: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(R9_PC42, R10_PC164) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.versions)) then
    return false
  end
  for key,value in pairs(self.versions) do
    -- DECOMPILER ERROR at PC228: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC229: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC42, R10_PC164) then
      return false
    end
    -- DECOMPILER ERROR at PC236: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC237: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC42, R10_PC164) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.reconnection) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.interrupt) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalDamage) then
    return false
  end
  return true
end

CBattleEnd.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC55: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.statuses)[key] = value
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
    -- DECOMPILER ERROR at PC96: Overwrote pending register: R8 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.enemyStatuses)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.operate):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.auto):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC158: Confused about usage of register: R14 in 'UnsetPending'

    (self.skills)[i] = ((require("protocols.bean.protocol.battle.usedequipskills")).Create)()
    if not ((self.skills)[i]):Unmarshal(buffer) then
      return false
    end
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
    -- DECOMPILER ERROR at PC197: Overwrote pending register: R12 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC203: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self.killMonsterNum)[key] = value
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
    -- DECOMPILER ERROR at PC233: Overwrote pending register: R15 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC239: Confused about usage of register: R20 in 'UnsetPending'

    ;
    (self.skillinfo)[key] = value
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
    -- DECOMPILER ERROR at PC269: Overwrote pending register: R18 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC275: Confused about usage of register: R23 in 'UnsetPending'

    ;
    (self.versions)[key] = value
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
  return ret
end

return CBattleEnd


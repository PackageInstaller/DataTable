-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/login/role.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Role = dataclass("Role")
Role.isLeader = 0
Role.id = 0
Role.birthday = 0
Role.breakLv = 0
Role.lv = 0
Role.exp = 0
Role.lock = 0
Role.evolution = 0
Role.power = 0
Role.energy = 0
Role.redDot = 0
Role.relationLevel = 0
Role.skin = 0
Role.goodProgress = 0
Role.specialWeaponLevel = 0
Role.runeLevel = 0
Role.Ctor = function(self)
  -- function num : 0_0
  self.properties = {}
  self.contractSkill = {}
  self.passiveskill = {}
  self.equips = {}
  self.preSetEquips = {}
  self.curLvBasePro = {}
  self.nextLvBasePro = {}
  self.breakLvRange = {}
  self.nextEvolutionLvBasePro = {}
  self.receiveList = {}
  self.unlockedNode = {}
  self.suitSkills = {}
  self.addPercent = {}
end

Role.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.isLeader) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.birthday) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.breakLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.exp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lock) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.properties)) then
    return false
  end
  for key,value in pairs(self.properties) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  local length = (table.slen)(self.contractSkill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC108: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.contractSkill)[i]):Marshal(R9_PC74) then
      return false
    end
  end
  local length = (table.slen)(self.passiveskill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC133: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.passiveskill)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.equips)) then
    return false
  end
  for key,value in pairs(self.equips) do
    -- DECOMPILER ERROR at PC156: Overwrote pending register: R9 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.preSetEquips)) then
    return false
  end
  for key,value in pairs(self.preSetEquips) do
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC191: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC199: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.evolution) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.curLvBasePro)) then
    return false
  end
  for key,value in pairs(self.curLvBasePro) do
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC232: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC240: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.nextLvBasePro)) then
    return false
  end
  for key,value in pairs(self.nextLvBasePro) do
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC265: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC273: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
  end
  local length = (table.slen)(self.breakLvRange)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    R9_PC74 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC299: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC300: Overwrote pending register: R11 in 'AssignReg'

    R9_PC74 = R9_PC74(buffer, R11_PC159)
    if not R9_PC74 then
      R9_PC74 = false
      return R9_PC74
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.nextEvolutionLvBasePro)) then
    return false
  end
  for key,R9_PC74 in pairs(self.nextEvolutionLvBasePro) do
    -- DECOMPILER ERROR at PC323: Overwrote pending register: R11 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R11_PC159, R12_PC325) then
      return false
    end
    -- DECOMPILER ERROR at PC331: Overwrote pending register: R11 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R11_PC159, R12_PC325) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.energy) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.redDot) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.relationLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodProgress) then
    return false
  end
  local length = (table.slen)(self.receiveList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC405: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC406: Overwrote pending register: R12 in 'AssignReg'

    -- DECOMPILER ERROR at PC407: Overwrote pending register: R12 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R11_PC159, R12_PC325) then
      return false
    end
  end
  local length = (table.slen)(self.unlockedNode)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC430: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC431: Overwrote pending register: R12 in 'AssignReg'

    R11_PC159 = R11_PC159(R12_PC325, (self.unlockedNode)[i])
    if not R11_PC159 then
      R11_PC159 = false
      return R11_PC159
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.suitSkills)) then
    return false
  end
  for key,R11_PC159 in pairs(self.suitSkills) do
    -- DECOMPILER ERROR at PC455: Overwrote pending register: R12 in 'AssignReg'

    R12_PC325 = R12_PC325(buffer, R14_PC458)
    if not R12_PC325 then
      R12_PC325 = false
      return R12_PC325
    end
    R12_PC325 = R12_PC325(value, R14_PC458)
    if not R12_PC325 then
      R12_PC325 = false
      return R12_PC325
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.specialWeaponLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.addPercent)) then
    return false
  end
  for key,value in pairs(self.addPercent) do
    R12_PC325 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC497: Overwrote pending register: R14 in 'AssignReg'

    R12_PC325 = R12_PC325(buffer, R14_PC458)
    if not R12_PC325 then
      R12_PC325 = false
      return R12_PC325
    end
    R12_PC325 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC505: Overwrote pending register: R14 in 'AssignReg'

    R12_PC325 = R12_PC325(buffer, R14_PC458)
    if not R12_PC325 then
      R12_PC325 = false
      return R12_PC325
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.runeLevel) then
    return false
  end
  return true
end

Role.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
    -- DECOMPILER ERROR at PC85: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.properties)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R11 in 'UnsetPending'

    (self.contractSkill)[i] = ((require("protocols.bean.protocol.skill.beans.skillitem")).Create)()
    if not ((self.contractSkill)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R12 in 'UnsetPending'

    (self.passiveskill)[i] = ((require("protocols.bean.protocol.login.passiveskill")).Create)()
    if not ((self.passiveskill)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC181: Overwrote pending register: R10 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC187: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.equips)[key] = value
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
    -- DECOMPILER ERROR at PC217: Overwrote pending register: R13 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC223: Confused about usage of register: R18 in 'UnsetPending'

    ;
    (self.preSetEquips)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
    -- DECOMPILER ERROR at PC261: Overwrote pending register: R16 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC267: Confused about usage of register: R21 in 'UnsetPending'

    ;
    (self.curLvBasePro)[key] = value
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
    -- DECOMPILER ERROR at PC297: Overwrote pending register: R19 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC303: Confused about usage of register: R24 in 'UnsetPending'

    ;
    (self.nextLvBasePro)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC322: Confused about usage of register: R25 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
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
    -- DECOMPILER ERROR at PC356: Overwrote pending register: R23 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC362: Confused about usage of register: R28 in 'UnsetPending'

    ;
    (self.nextEvolutionLvBasePro)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC429: Confused about usage of register: R29 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC452: Confused about usage of register: R30 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
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
    -- DECOMPILER ERROR at PC488: Overwrote pending register: R28 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC497: Confused about usage of register: R33 in 'UnsetPending'

    ;
    (self.suitSkills)[key] = value
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
    -- DECOMPILER ERROR at PC535: Overwrote pending register: R31 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC541: Confused about usage of register: R36 in 'UnsetPending'

    ;
    (self.addPercent)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Role


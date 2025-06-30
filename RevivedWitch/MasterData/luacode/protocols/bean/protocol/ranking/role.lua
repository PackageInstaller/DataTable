-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/role.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Role = dataclass("Role")
Role.id = 0
Role.breakLv = 0
Role.lv = 0
Role.evolution = 0
Role.power = 0
Role.skin = 0
Role.specialWeaponLevel = 0
Role.runeLevel = 0
Role.Ctor = function(self)
  -- function num : 0_0
  self.properties = {}
  self.contractSkill = {}
  self.passiveskill = {}
  self.equips = {}
  self.curLvBasePro = {}
end

Role.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.breakLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.properties)) then
    return false
  end
  for key,value in pairs(self.properties) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
  end
  local length = (table.slen)(self.contractSkill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC76: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.contractSkill)[i]):Marshal(R9_PC42) then
      return false
    end
  end
  local length = (table.slen)(self.passiveskill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC101: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.passiveskill)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.equips)) then
    return false
  end
  for key,value in pairs(self.equips) do
    -- DECOMPILER ERROR at PC124: Overwrote pending register: R9 in 'AssignReg'

    R9_PC42 = R9_PC42(buffer, R11_PC127)
    if not R9_PC42 then
      R9_PC42 = false
      return R9_PC42
    end
    R9_PC42 = R9_PC42(value, R11_PC127)
    if not R9_PC42 then
      R9_PC42 = false
      return R9_PC42
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.evolution) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.curLvBasePro)) then
    return false
  end
  for key,value in pairs(self.curLvBasePro) do
    R9_PC42 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC166: Overwrote pending register: R11 in 'AssignReg'

    R9_PC42 = R9_PC42(buffer, R11_PC127)
    if not R9_PC42 then
      R9_PC42 = false
      return R9_PC42
    end
    R9_PC42 = ProtocolBufferStaticFunctions.WriteInt32
    -- DECOMPILER ERROR at PC174: Overwrote pending register: R11 in 'AssignReg'

    R9_PC42 = R9_PC42(buffer, R11_PC127)
    if not R9_PC42 then
      R9_PC42 = false
      return R9_PC42
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.specialWeaponLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.runeLevel) then
    return false
  end
  return true
end

Role.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
    -- DECOMPILER ERROR at PC53: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.properties)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R11 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R12 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC151: Overwrote pending register: R10 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.equips)[key] = value
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
    -- DECOMPILER ERROR at PC198: Overwrote pending register: R13 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC204: Confused about usage of register: R18 in 'UnsetPending'

    ;
    (self.curLvBasePro)[key] = value
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
  return ret
end

return Role


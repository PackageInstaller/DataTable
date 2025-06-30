-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/shandbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SHandbook = dataclass("SHandbook", require("framework.net.protocol"))
SHandbook.ProtocolType = 2259
SHandbook.MaxSize = 65535
SHandbook.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SHandbook
  ((SHandbook.super).Ctor)(self, client)
  self.equips = {}
  self.monsters = {}
  self.roles = {}
  self.npc = {}
  self.worlds = {}
  self.forces = {}
  self.activities = {}
  self.soulNums = {}
  self.lockedRoles = {}
end

SHandbook.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.equips)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.equips)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.monsters)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.monsters)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roles)) then
    return false
  end
  for key,value in pairs(self.roles) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R11_PC70) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R11_PC70) then
      return false
    end
  end
  local length = (table.slen)(self.npc)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC103: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC104: Overwrote pending register: R11 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R11_PC70) then
      return false
    end
  end
  local length = (table.slen)(self.worlds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC128: Overwrote pending register: R11 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R11_PC70, (self.worlds)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.forces)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC153: Overwrote pending register: R11 in 'AssignReg'

    R11_PC70 = R11_PC70(buffer, (self.forces)[i])
    if not R11_PC70 then
      R11_PC70 = false
      return R11_PC70
    end
  end
  local length = (table.slen)(self.activities)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for R11_PC70 = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.activities)[i]) then
      return false
    end
  end
  -- DECOMPILER ERROR at PC189: Confused about usage of register R10 for local variables in 'ReleaseLocals'

  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.soulNums)) then
    return false
  end
  for key,value in pairs(self.soulNums) do
    local key, value = nil
    key = ProtocolBufferStaticFunctions.WriteInt32
    value = buffer
    key = key(value, R15_PC207)
    if not key then
      key = false
      return key
    end
    key = ProtocolBufferStaticFunctions.WriteInt32
    value = buffer
    R15_PC207 = l_0_1_39
    key = key(value, R15_PC207)
    if not key then
      key = false
      return key
    end
  end
  local length = nil
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(length, (table.slen)(self.lockedRoles)) then
    return false
  end
  -- DECOMPILER ERROR at PC235: Overwrote pending register: R10 in 'AssignReg'

  for i = 1, length do
    local l_0_1_45, i = nil
    l_0_1_45 = ProtocolBufferStaticFunctions.WriteInt32
    i = buffer
    R15_PC207 = self.lockedRoles
    R15_PC207 = R15_PC207[l_0_1_44]
    l_0_1_45 = l_0_1_45(i, R15_PC207)
    if not l_0_1_45 then
      l_0_1_45 = false
      return l_0_1_45
    end
  end
  return true
end

SHandbook.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC75: Overwrote pending register: R7 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.roles)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R13 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC123: Confused about usage of register: R14 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC146: Confused about usage of register: R15 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC169: Confused about usage of register: R16 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC203: Overwrote pending register: R14 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC209: Confused about usage of register: R19 in 'UnsetPending'

    ;
    (self.soulNums)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC228: Confused about usage of register: R20 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SHandbook


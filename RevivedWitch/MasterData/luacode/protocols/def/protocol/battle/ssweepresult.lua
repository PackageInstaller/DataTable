-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ssweepresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSweepResult = dataclass("SSweepResult", require("framework.net.protocol"))
SSweepResult.ProtocolType = 4139
SSweepResult.MaxSize = 65535
SSweepResult.playerExp = 0
SSweepResult.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSweepResult
  ((SSweepResult.super).Ctor)(self, client)
  self.itemList = {}
  self.money = {}
  self.roleExp = {}
  self.roleGoodCurExp = {}
  self.roleGoodLv = {}
  self.roleGoodExp = {}
  self.rolesIndex = {}
  self.restituteReward = {}
end

SSweepResult.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.itemList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.itemList)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.money)) then
    return false
  end
  for key,value in pairs(self.money) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.playerExp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleExp)) then
    return false
  end
  for key,value in pairs(self.roleExp) do
    -- DECOMPILER ERROR at PC84: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC92: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodCurExp)) then
    return false
  end
  for key,value in pairs(self.roleGoodCurExp) do
    -- DECOMPILER ERROR at PC117: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC125: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodLv)) then
    return false
  end
  for key,value in pairs(self.roleGoodLv) do
    -- DECOMPILER ERROR at PC150: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC158: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodExp)) then
    return false
  end
  for key,value in pairs(self.roleGoodExp) do
    -- DECOMPILER ERROR at PC183: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC191: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.rolesIndex)) then
    return false
  end
  for key,value in pairs(self.rolesIndex) do
    -- DECOMPILER ERROR at PC216: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC224: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.restituteReward)) then
    return false
  end
  for key,value in pairs(self.restituteReward) do
    -- DECOMPILER ERROR at PC249: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    -- DECOMPILER ERROR at PC257: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC44) then
      return false
    end
  end
  return true
end

SSweepResult.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.itemList)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemList)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC59: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.money)[key] = value
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
    -- DECOMPILER ERROR at PC103: Overwrote pending register: R9 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.roleExp)[key] = value
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
    -- DECOMPILER ERROR at PC139: Overwrote pending register: R12 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC145: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self.roleGoodCurExp)[key] = value
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
    -- DECOMPILER ERROR at PC175: Overwrote pending register: R15 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC181: Confused about usage of register: R20 in 'UnsetPending'

    ;
    (self.roleGoodLv)[key] = value
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
    -- DECOMPILER ERROR at PC211: Overwrote pending register: R18 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC217: Confused about usage of register: R23 in 'UnsetPending'

    ;
    (self.roleGoodExp)[key] = value
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
    -- DECOMPILER ERROR at PC247: Overwrote pending register: R21 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC253: Confused about usage of register: R26 in 'UnsetPending'

    ;
    (self.rolesIndex)[key] = value
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
    -- DECOMPILER ERROR at PC283: Overwrote pending register: R24 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC289: Confused about usage of register: R29 in 'UnsetPending'

    ;
    (self.restituteReward)[key] = value
  end
  return ret
end

return SSweepResult


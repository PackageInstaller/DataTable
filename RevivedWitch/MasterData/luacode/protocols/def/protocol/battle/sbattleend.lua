-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBattleEnd = dataclass("SBattleEnd", require("framework.net.protocol"))
SBattleEnd.ProtocolType = 1904
SBattleEnd.MaxSize = 65535
SBattleEnd.battleType = 0
SBattleEnd.id = 0
SBattleEnd.battleTime = 0
SBattleEnd.playerExp = 0
SBattleEnd.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBattleEnd, _ENV
  ((SBattleEnd.super).Ctor)(self, client)
  self.battleResult = ((require("protocols.bean.protocol.battle.battleresult")).Create)()
  self.itemList = {}
  self.money = {}
  self.roleExp = {}
  self.roleGoodCurExp = {}
  self.roleGoodLv = {}
  self.roleGoodExp = {}
  self.rolesIndex = {}
end

SBattleEnd.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (self.battleResult):Marshal(buffer) then
    return false
  end
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
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC68) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.battleTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.playerExp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleExp)) then
    return false
  end
  for key,value in pairs(self.roleExp) do
    -- DECOMPILER ERROR at PC116: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    -- DECOMPILER ERROR at PC124: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC68) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodCurExp)) then
    return false
  end
  for key,value in pairs(self.roleGoodCurExp) do
    -- DECOMPILER ERROR at PC149: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    -- DECOMPILER ERROR at PC157: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodLv)) then
    return false
  end
  for key,value in pairs(self.roleGoodLv) do
    -- DECOMPILER ERROR at PC182: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    -- DECOMPILER ERROR at PC190: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleGoodExp)) then
    return false
  end
  for key,value in pairs(self.roleGoodExp) do
    -- DECOMPILER ERROR at PC215: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    -- DECOMPILER ERROR at PC223: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  local length = (table.slen)(self.rolesIndex)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC249: Overwrote pending register: R10 in 'AssignReg'

    -- DECOMPILER ERROR at PC250: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  return true
end

SBattleEnd.Unmarshal = function(self, buffer)
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
  if not (self.battleResult):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC83: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.money)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC135: Overwrote pending register: R9 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC141: Confused about usage of register: R14 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC171: Overwrote pending register: R12 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC177: Confused about usage of register: R17 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC207: Overwrote pending register: R15 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC213: Confused about usage of register: R20 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC243: Overwrote pending register: R18 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC249: Confused about usage of register: R23 in 'UnsetPending'

    ;
    (self.roleGoodExp)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC268: Confused about usage of register: R24 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SBattleEnd


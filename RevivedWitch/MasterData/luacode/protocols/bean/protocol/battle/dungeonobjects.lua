-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/dungeonobjects.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local DungeonObjects = dataclass("DungeonObjects")
DungeonObjects.Ctor = function(self)
  -- function num : 0_0
  self.items = {}
  self.objs = {}
  self.npcs = {}
  self.monsterIds = {}
  self.movableMonstersPosition = {}
  self.box = {}
end

DungeonObjects.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.items)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.items)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.objs)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.objs)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.npcs)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.npcs)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.monsterIds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.monsterIds)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.movableMonstersPosition)) then
    return false
  end
  for key,value in pairs(self.movableMonstersPosition) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R13_PC122) then
      return false
    end
    if not value:Marshal(R13_PC122) then
      return false
    end
  end
  local length = (table.slen)(self.box)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC154: Overwrote pending register: R13 in 'AssignReg'

    -- DECOMPILER ERROR at PC155: Overwrote pending register: R13 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R13_PC122) then
      return false
    end
  end
  return true
end

DungeonObjects.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.items)[i] = ((require("protocols.bean.protocol.battle.randomitem")).Create)()
    if not ((self.items)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.objs)[i] = ((require("protocols.bean.protocol.battle.dungeonobj")).Create)()
    if not ((self.objs)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

    (self.npcs)[i] = ((require("protocols.bean.protocol.battle.dungeonnpc")).Create)()
    if not ((self.npcs)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC108: Confused about usage of register: R11 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC144: Overwrote pending register: R9 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC153: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.movableMonstersPosition)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC172: Confused about usage of register: R15 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return DungeonObjects


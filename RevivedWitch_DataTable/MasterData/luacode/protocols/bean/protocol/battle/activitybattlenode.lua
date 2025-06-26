-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/activitybattlenode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ActivityBattleNode = dataclass("ActivityBattleNode")
ActivityBattleNode.id = 0
ActivityBattleNode.status = 0
ActivityBattleNode.level = 0
ActivityBattleNode.battletype = 0
ActivityBattleNode.spirit = 0
ActivityBattleNode.first = 0
ActivityBattleNode.bossLevel = 0
ActivityBattleNode.lefttime = 0
ActivityBattleNode.lefthp = 0
ActivityBattleNode.LOCK = 0
ActivityBattleNode.UNSTART = 1
ActivityBattleNode.UNCLEAR = 2
ActivityBattleNode.CLEAR = 3
ActivityBattleNode.PASSED = 4
ActivityBattleNode.BEFORE_CLEAR = 5
ActivityBattleNode.Ctor = function(self)
  -- function num : 0_0
  self.firstItems = {}
  self.normalItems = {}
  self.randItems = {}
end

ActivityBattleNode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battletype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spirit) then
    return false
  end
  local length = (table.slen)(self.firstItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.firstItems)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.normalItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.normalItems)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.randItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.randItems)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.first) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.lefttime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.lefthp) then
    return false
  end
  return true
end

ActivityBattleNode.Unmarshal = function(self, buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    (self.firstItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.firstItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R9 in 'UnsetPending'

    (self.normalItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.normalItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC120: Confused about usage of register: R10 in 'UnsetPending'

    (self.randItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.randItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ActivityBattleNode


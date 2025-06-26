-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/senterdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEnterDungeon = dataclass("SEnterDungeon", require("framework.net.protocol"))
SEnterDungeon.ProtocolType = 1913
SEnterDungeon.MaxSize = 655350
SEnterDungeon.id = 0
SEnterDungeon.lineupId = 0
SEnterDungeon.gold = 0
SEnterDungeon.lastbattleid = 0
SEnterDungeon.battleresult = 0
SEnterDungeon.mapOpened = 0
SEnterDungeon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEnterDungeon, _ENV
  ((SEnterDungeon.super).Ctor)(self, client)
  self.point = ((require("protocols.bean.protocol.battle.point")).Create)()
  self.reconnect = ((require("protocols.bean.protocol.battle.triggerobject")).Create)()
  self.traps = {}
  self.switches = {}
  self.objects = ((require("protocols.bean.protocol.battle.dungeonobjects")).Create)()
  self.points = {}
  self.prePoints = {}
  self.activedOptionIds = {}
  self.specialPoint = {}
  self.curBattleInfo = ((require("protocols.bean.protocol.battle.battleinfo")).Create)()
  self.modules = {}
  self.buffs = {}
end

SEnterDungeon.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  if not (self.point):Marshal(buffer) then
    return false
  end
  if not (self.reconnect):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.traps)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.traps)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.switches)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.switches)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.objects):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.points)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, (self.points)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.prePoints)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, (self.prePoints)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.activedOptionIds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.activedOptionIds)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.specialPoint)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.specialPoint)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.gold) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lastbattleid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleresult) then
    return false
  end
  if not (self.curBattleInfo):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.modules)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.modules)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.mapOpened) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.buffs)) then
    return false
  end
  for key,value in pairs(self.buffs) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R16_PC280) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R16_PC280) then
      return false
    end
  end
  return true
end

SEnterDungeon.Unmarshal = function(self, buffer)
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
  if not (self.point):Unmarshal(buffer) then
    return false
  end
  if not (self.reconnect):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    (self.traps)[i] = ((require("protocols.bean.protocol.battle.exploreinstance")).Create)()
    if not ((self.traps)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R9 in 'UnsetPending'

    (self.switches)[i] = ((require("protocols.bean.protocol.battle.switchesinstance")).Create)()
    if not ((self.switches)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.objects):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R10 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
    -- DECOMPILER ERROR at PC141: Confused about usage of register: R11 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
    -- DECOMPILER ERROR at PC164: Confused about usage of register: R12 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC189: Confused about usage of register: R13 in 'UnsetPending'

    (self.specialPoint)[i] = ((require("protocols.bean.protocol.battle.point")).Create)()
    if not ((self.specialPoint)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
  if not (self.curBattleInfo):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC251: Confused about usage of register: R14 in 'UnsetPending'

    (self.modules)[i] = ((require("protocols.bean.protocol.battle.module")).Create)()
    if not ((self.modules)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
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
    -- DECOMPILER ERROR at PC298: Overwrote pending register: R12 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC304: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self.buffs)[key] = value
  end
  return ret
end

return SEnterDungeon


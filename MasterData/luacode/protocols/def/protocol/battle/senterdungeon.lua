local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnterDungeon = dataclass("SEnterDungeon", require("framework.net.protocol"))
SEnterDungeon.ProtocolType = 1913
SEnterDungeon.MaxSize = 655350
SEnterDungeon.id = 0
SEnterDungeon.lineupId = 0
SEnterDungeon.gold = 0
SEnterDungeon.lastbattleid = 0
SEnterDungeon.battleresult = 0
SEnterDungeon.mapOpened = 0

function SEnterDungeon:Ctor(client)
  SEnterDungeon.super.Ctor(self, client)
  self.point = require("protocols.bean.protocol.battle.point").Create()
  self.reconnect = require("protocols.bean.protocol.battle.triggerobject").Create()
  self.traps = {}
  self.switches = {}
  self.objects = require("protocols.bean.protocol.battle.dungeonobjects").Create()
  self.points = {}
  self.prePoints = {}
  self.activedOptionIds = {}
  self.specialPoint = {}
  self.curBattleInfo = require("protocols.bean.protocol.battle.battleinfo").Create()
  self.modules = {}
  self.buffs = {}
end

function SEnterDungeon:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not self.point:Marshal(buffer) then
    return false
  end
  if not self.reconnect:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.traps)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.traps[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.switches)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.switches[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.objects:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.points)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.points[i]) then
      return false
    end
  end
  local length = table.slen(self.prePoints)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.prePoints[i]) then
      return false
    end
  end
  local length = table.slen(self.activedOptionIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activedOptionIds[i]) then
      return false
    end
  end
  local length = table.slen(self.specialPoint)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.specialPoint[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.gold) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lastbattleid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleresult) then
    return false
  end
  if not self.curBattleInfo:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.modules)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.modules[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.mapOpened) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.buffs)) then
    return false
  end
  for key, value in pairs(self.buffs) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SEnterDungeon:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.point:Unmarshal(buffer) then
    return false
  end
  if not self.reconnect:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.traps[i] = require("protocols.bean.protocol.battle.exploreinstance").Create()
    if not self.traps[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.switches[i] = require("protocols.bean.protocol.battle.switchesinstance").Create()
    if not self.switches[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.objects:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.points[i] = ProtocolBufferStaticFunctions.ReadInt16(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.prePoints[i] = ProtocolBufferStaticFunctions.ReadInt16(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.activedOptionIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.specialPoint[i] = require("protocols.bean.protocol.battle.point").Create()
    if not self.specialPoint[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.gold = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.lastbattleid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleresult = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.curBattleInfo:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.modules[i] = require("protocols.bean.protocol.battle.module").Create()
    if not self.modules[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.mapOpened = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.buffs[key] = value
  end
  return ret
end

return SEnterDungeon

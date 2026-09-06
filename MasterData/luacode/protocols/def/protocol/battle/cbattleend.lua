local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
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

function CBattleEnd:Ctor(client)
  CBattleEnd.super.Ctor(self, client)
  self.statuses = {}
  self.enemyStatuses = {}
  self.operate = require("protocols.bean.protocol.battle.verifyinfolistbean").Create()
  self.auto = require("protocols.bean.protocol.battle.autofightskills").Create()
  self.skills = {}
  self.killMonsterNum = {}
  self.skillinfo = {}
  self.versions = {}
end

function CBattleEnd:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battletype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.statuses)) then
    return false
  end
  for key, value in pairs(self.statuses) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.enemyStatuses)) then
    return false
  end
  for key, value in pairs(self.enemyStatuses) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isAssisted) then
    return false
  end
  if not self.operate:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stepNum) then
    return false
  end
  if not self.auto:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.skills)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.skills[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.killMonsterNum)) then
    return false
  end
  for key, value in pairs(self.killMonsterNum) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.skillinfo)) then
    return false
  end
  for key, value in pairs(self.skillinfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.versions)) then
    return false
  end
  for key, value in pairs(self.versions) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.reconnection) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.interrupt) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalDamage) then
    return false
  end
  return true
end

function CBattleEnd:Unmarshal(buffer)
  local ret = true
  ret, self.battletype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.battle.status").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.statuses[key] = value
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
    value = require("protocols.bean.protocol.battle.status").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.enemyStatuses[key] = value
  end
  ret, self.isAssisted = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.operate:Unmarshal(buffer) then
    return false
  end
  ret, self.stepNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.auto:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.skills[i] = require("protocols.bean.protocol.battle.usedequipskills").Create()
    if not self.skills[i]:Unmarshal(buffer) then
      return false
    end
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
    self.killMonsterNum[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
    self.skillinfo[key] = value
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
    self.versions[key] = value
  end
  ret, self.reconnection = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.interrupt = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalDamage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBattleEnd

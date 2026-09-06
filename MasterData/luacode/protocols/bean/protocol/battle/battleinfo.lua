local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BattleInfo = dataclass("BattleInfo")
BattleInfo.id = 0
BattleInfo.battleType = 0
BattleInfo.battleid = 0
BattleInfo.battleSceneId = 0
BattleInfo.lineId = 0
BattleInfo.leftAssistNum = 0
BattleInfo.totalAssistNum = 0
BattleInfo.seed = 0
BattleInfo.guide = 0
BattleInfo.battleVerifyNum = 0
BattleInfo.battleDuration = 0

function BattleInfo:Ctor()
  self.left = {}
  self.right = {}
  self.assist = require("protocols.bean.protocol.battle.fighter").Create()
  self.auto = require("protocols.bean.protocol.battle.autofightskills").Create()
  self.battleBuffs = {}
end

function BattleInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleSceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.left)) then
    return false
  end
  for key, value in pairs(self.left) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.right)) then
    return false
  end
  for key, value in pairs(self.right) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not self.assist:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftAssistNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalAssistNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seed) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guide) then
    return false
  end
  if not self.auto:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.battleVerifyNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.battleDuration) then
    return false
  end
  local length = table.slen(self.battleBuffs)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.battleBuffs[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function BattleInfo:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleSceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.battle.fighter").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.left[key] = value
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
    value = require("protocols.bean.protocol.battle.fighter").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.right[key] = value
  end
  if not self.assist:Unmarshal(buffer) then
    return false
  end
  ret, self.leftAssistNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalAssistNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.seed = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.guide = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.auto:Unmarshal(buffer) then
    return false
  end
  ret, self.battleVerifyNum = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.battleDuration = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.battleBuffs[i] = require("protocols.bean.protocol.battle.battlebuff").Create()
    if not self.battleBuffs[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return BattleInfo

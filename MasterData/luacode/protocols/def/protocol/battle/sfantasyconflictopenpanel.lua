local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictOpenPanel = dataclass("SFantasyConflictOpenPanel", require("framework.net.protocol"))
SFantasyConflictOpenPanel.ProtocolType = 4150
SFantasyConflictOpenPanel.MaxSize = 65535
SFantasyConflictOpenPanel.waiting = 0
SFantasyConflictOpenPanel.seasonId = 0
SFantasyConflictOpenPanel.currentScore = 0
SFantasyConflictOpenPanel.stage = 0
SFantasyConflictOpenPanel.leftEnterTimes = 0
SFantasyConflictOpenPanel.leftAttackAccessPoint = 0
SFantasyConflictOpenPanel.leftDefendAccessPoint = 0
SFantasyConflictOpenPanel.leftDefendLosePoint = 0
SFantasyConflictOpenPanel.leftTime = 0

function SFantasyConflictOpenPanel:Ctor(client)
  SFantasyConflictOpenPanel.super.Ctor(self, client)
  self.enemyInfo = {}
  self.attackTeam = {}
  self.defendTeam = {}
end

function SFantasyConflictOpenPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.waiting) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftEnterTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftAttackAccessPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftDefendAccessPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftDefendLosePoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.enemyInfo)) then
    return false
  end
  for key, value in pairs(self.enemyInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.attackTeam)) then
    return false
  end
  for key, value in pairs(self.attackTeam) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.defendTeam)) then
    return false
  end
  for key, value in pairs(self.defendTeam) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SFantasyConflictOpenPanel:Unmarshal(buffer)
  local ret = true
  ret, self.waiting = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.currentScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftEnterTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftAttackAccessPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftDefendAccessPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftDefendLosePoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.battle.fantasyconflictenemylineup").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.enemyInfo[key] = value
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    self.attackTeam[key] = value
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
    self.defendTeam[key] = value
  end
  return ret
end

return SFantasyConflictOpenPanel

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartAutoExplore = dataclass("SStartAutoExplore", require("framework.net.protocol"))
SStartAutoExplore.ProtocolType = 1964
SStartAutoExplore.MaxSize = 65535
SStartAutoExplore.zoneId = 0
SStartAutoExplore.dungeonType = 0
SStartAutoExplore.lastBattleId = 0
SStartAutoExplore.battleResult = 0

function SStartAutoExplore:Ctor(client)
  SStartAutoExplore.super.Ctor(self, client)
  self.monsters = {}
  self.curBattleInfo = require("protocols.bean.protocol.battle.battleinfo").Create()
end

function SStartAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.monsters)) then
    return false
  end
  for key, value in pairs(self.monsters) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lastBattleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleResult) then
    return false
  end
  if not self.curBattleInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SStartAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.zoneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dungeonType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.monsters[key] = value
  end
  ret, self.lastBattleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleResult = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.curBattleInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SStartAutoExplore

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBattleStart = dataclass("CBattleStart", require("framework.net.protocol"))
CBattleStart.ProtocolType = 1901
CBattleStart.MaxSize = 65535
CBattleStart.battleType = 0
CBattleStart.id = 0
CBattleStart.battleSceneId = 0
CBattleStart.lineupID = 0
CBattleStart.TOWER = 1
CBattleStart.SHATTERED = 2
CBattleStart.DUNGEON = 3
CBattleStart.TEST = 4
CBattleStart.RESOURCE = 5
CBattleStart.BOSS_RUSH = 6
CBattleStart.ARENA = 7
CBattleStart.STARRY = 8
CBattleStart.UNDECIDEDROAD = 9
CBattleStart.SUMMER = 10
CBattleStart.CHRISTMAS = 11
CBattleStart.SPRING_FESTIVAL = 12
CBattleStart.LOVER = 13
CBattleStart.WEEK_BOSS = 14
CBattleStart.ANNIVERSARY = 15
CBattleStart.STARRY_MIRROR = 16
CBattleStart.SUMMER_ECHO = 17
CBattleStart.PARTY_BOSS = 18
CBattleStart.FANTASY_CONFLICT = 19

function CBattleStart:Ctor(client)
  CBattleStart.super.Ctor(self, client)
  self.lineup = {}
end

function CBattleStart:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleSceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.lineup)) then
    return false
  end
  for key, value in pairs(self.lineup) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CBattleStart:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleSceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineupID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.lineup[key] = value
  end
  return ret
end

return CBattleStart

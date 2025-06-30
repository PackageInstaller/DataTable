-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
CBattleStart.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBattleStart
  ((CBattleStart.super).Ctor)(self, client)
  self.lineup = {}
end

CBattleStart.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleSceneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.lineup)) then
    return false
  end
  for key,value in pairs(self.lineup) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
  end
  return true
end

CBattleStart.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
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
    -- DECOMPILER ERROR at PC61: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.lineup)[key] = value
  end
  return ret
end

return CBattleStart


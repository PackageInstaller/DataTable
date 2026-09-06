local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local RankType = dataclass("RankType")
RankType.BOSS_CHALLENGE = 1
RankType.ARENA_PVP = 2
RankType.PARTY_ACTIVE = 5
RankType.PARTY_LEVEL = 6
RankType.UNDECIDED_CHALLENGE = 7
RankType.WATERMELON = 8
RankType.CHRISTMAS_SUPPORT = 9
RankType.SPRING_FESTIVAL = 10
RankType.WEEK_BOSS_CHALLENGE = 11
RankType.SUMMER_ECHO = 12
RankType.ROUGE_TOWER = 14
RankType.FLOWER_SEND = 15
RankType.FLOWER_RECEIVE = 16

function RankType:Ctor()
end

function RankType:Marshal(buffer)
  return true
end

function RankType:Unmarshal(buffer)
  local ret = true
  return ret
end

return RankType

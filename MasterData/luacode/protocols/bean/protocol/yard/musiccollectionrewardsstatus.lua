local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MusicCollectionRewardsStatus = dataclass("MusicCollectionRewardsStatus")
MusicCollectionRewardsStatus.UNFINISHED = 1
MusicCollectionRewardsStatus.AVAILABLE = 2
MusicCollectionRewardsStatus.RECEIVED = 3

function MusicCollectionRewardsStatus:Ctor()
end

function MusicCollectionRewardsStatus:Marshal(buffer)
  return true
end

function MusicCollectionRewardsStatus:Unmarshal(buffer)
  local ret = true
  return ret
end

return MusicCollectionRewardsStatus

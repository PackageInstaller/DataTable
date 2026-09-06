local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MusicCollectionRewardsInfo = dataclass("MusicCollectionRewardsInfo")
MusicCollectionRewardsInfo.rewardsId = 0
MusicCollectionRewardsInfo.rewardsStatue = 0

function MusicCollectionRewardsInfo:Ctor()
end

function MusicCollectionRewardsInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardsId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardsStatue) then
    return false
  end
  return true
end

function MusicCollectionRewardsInfo:Unmarshal(buffer)
  local ret = true
  ret, self.rewardsId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardsStatue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MusicCollectionRewardsInfo

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMusicCollectionRewardsAchieved = dataclass("SMusicCollectionRewardsAchieved", require("framework.net.protocol"))
SMusicCollectionRewardsAchieved.ProtocolType = 2388
SMusicCollectionRewardsAchieved.MaxSize = 65535

function SMusicCollectionRewardsAchieved:Ctor(client)
  SMusicCollectionRewardsAchieved.super.Ctor(self, client)
  self.musicCollectionRewardsStates = {}
end

function SMusicCollectionRewardsAchieved:Marshal(buffer)
  local length = table.slen(self.musicCollectionRewardsStates)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.musicCollectionRewardsStates[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SMusicCollectionRewardsAchieved:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.musicCollectionRewardsStates[i] = require("protocols.bean.protocol.yard.musiccollectionrewardsinfo").Create()
    if not self.musicCollectionRewardsStates[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SMusicCollectionRewardsAchieved

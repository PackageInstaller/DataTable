local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMusicCollectionRewardsGet = dataclass("CMusicCollectionRewardsGet", require("framework.net.protocol"))
CMusicCollectionRewardsGet.ProtocolType = 2387
CMusicCollectionRewardsGet.MaxSize = 65535

function CMusicCollectionRewardsGet:Ctor(client)
  CMusicCollectionRewardsGet.super.Ctor(self, client)
  self.musicCollectionRewardsList = {}
end

function CMusicCollectionRewardsGet:Marshal(buffer)
  local length = table.slen(self.musicCollectionRewardsList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.musicCollectionRewardsList[i]) then
      return false
    end
  end
  return true
end

function CMusicCollectionRewardsGet:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.musicCollectionRewardsList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CMusicCollectionRewardsGet

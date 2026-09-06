local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshRecommendedFriends = dataclass("CRefreshRecommendedFriends", require("framework.net.protocol"))
CRefreshRecommendedFriends.ProtocolType = 1120
CRefreshRecommendedFriends.MaxSize = 65535

function CRefreshRecommendedFriends:Ctor(client)
  CRefreshRecommendedFriends.super.Ctor(self, client)
end

function CRefreshRecommendedFriends:Marshal(buffer)
  return true
end

function CRefreshRecommendedFriends:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshRecommendedFriends

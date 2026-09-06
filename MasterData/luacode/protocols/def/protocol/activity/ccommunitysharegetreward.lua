local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommunityShareGetReward = dataclass("CCommunityShareGetReward", require("framework.net.protocol"))
CCommunityShareGetReward.ProtocolType = 2751
CCommunityShareGetReward.MaxSize = 65535

function CCommunityShareGetReward:Ctor(client)
  CCommunityShareGetReward.super.Ctor(self, client)
end

function CCommunityShareGetReward:Marshal(buffer)
  return true
end

function CCommunityShareGetReward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCommunityShareGetReward

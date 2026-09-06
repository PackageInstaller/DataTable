local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommunityShareActive = dataclass("CCommunityShareActive", require("framework.net.protocol"))
CCommunityShareActive.ProtocolType = 2750
CCommunityShareActive.MaxSize = 65535

function CCommunityShareActive:Ctor(client)
  CCommunityShareActive.super.Ctor(self, client)
end

function CCommunityShareActive:Marshal(buffer)
  return true
end

function CCommunityShareActive:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCommunityShareActive

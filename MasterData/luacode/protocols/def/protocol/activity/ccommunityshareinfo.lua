local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommunityShareInfo = dataclass("CCommunityShareInfo", require("framework.net.protocol"))
CCommunityShareInfo.ProtocolType = 2752
CCommunityShareInfo.MaxSize = 65535

function CCommunityShareInfo:Ctor(client)
  CCommunityShareInfo.super.Ctor(self, client)
end

function CCommunityShareInfo:Marshal(buffer)
  return true
end

function CCommunityShareInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCommunityShareInfo

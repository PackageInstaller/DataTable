local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshFriendInfos = dataclass("CRefreshFriendInfos", require("framework.net.protocol"))
CRefreshFriendInfos.ProtocolType = 1129
CRefreshFriendInfos.MaxSize = 65535

function CRefreshFriendInfos:Ctor(client)
  CRefreshFriendInfos.super.Ctor(self, client)
end

function CRefreshFriendInfos:Marshal(buffer)
  return true
end

function CRefreshFriendInfos:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshFriendInfos

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNotifyFriendsPoint = dataclass("SNotifyFriendsPoint", require("framework.net.protocol"))
SNotifyFriendsPoint.ProtocolType = 1155
SNotifyFriendsPoint.MaxSize = 65535

function SNotifyFriendsPoint:Ctor(client)
  SNotifyFriendsPoint.super.Ctor(self, client)
end

function SNotifyFriendsPoint:Marshal(buffer)
  return true
end

function SNotifyFriendsPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SNotifyFriendsPoint

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChargeFriendsPoint = dataclass("CChargeFriendsPoint", require("framework.net.protocol"))
CChargeFriendsPoint.ProtocolType = 1156
CChargeFriendsPoint.MaxSize = 65535

function CChargeFriendsPoint:Ctor(client)
  CChargeFriendsPoint.super.Ctor(self, client)
end

function CChargeFriendsPoint:Marshal(buffer)
  return true
end

function CChargeFriendsPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return CChargeFriendsPoint

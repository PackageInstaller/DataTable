local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SInviteWeekShare = dataclass("SInviteWeekShare", require("framework.net.protocol"))
SInviteWeekShare.ProtocolType = 2468
SInviteWeekShare.MaxSize = 65535

function SInviteWeekShare:Ctor(client)
  SInviteWeekShare.super.Ctor(self, client)
end

function SInviteWeekShare:Marshal(buffer)
  return true
end

function SInviteWeekShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return SInviteWeekShare

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CInviteWeekShare = dataclass("CInviteWeekShare", require("framework.net.protocol"))
CInviteWeekShare.ProtocolType = 2467
CInviteWeekShare.MaxSize = 65535

function CInviteWeekShare:Ctor(client)
  CInviteWeekShare.super.Ctor(self, client)
end

function CInviteWeekShare:Marshal(buffer)
  return true
end

function CInviteWeekShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return CInviteWeekShare

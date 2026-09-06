local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenInviteeList = dataclass("COpenInviteeList", require("framework.net.protocol"))
COpenInviteeList.ProtocolType = 2458
COpenInviteeList.MaxSize = 65535

function COpenInviteeList:Ctor(client)
  COpenInviteeList.super.Ctor(self, client)
end

function COpenInviteeList:Marshal(buffer)
  return true
end

function COpenInviteeList:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenInviteeList

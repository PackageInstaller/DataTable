local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenInviteShare = dataclass("COpenInviteShare", require("framework.net.protocol"))
COpenInviteShare.ProtocolType = 2465
COpenInviteShare.MaxSize = 65535

function COpenInviteShare:Ctor(client)
  COpenInviteShare.super.Ctor(self, client)
end

function COpenInviteShare:Marshal(buffer)
  return true
end

function COpenInviteShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenInviteShare

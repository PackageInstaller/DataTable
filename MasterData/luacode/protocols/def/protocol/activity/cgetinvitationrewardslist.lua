local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetInvitationRewardsList = dataclass("CGetInvitationRewardsList", require("framework.net.protocol"))
CGetInvitationRewardsList.ProtocolType = 2460
CGetInvitationRewardsList.MaxSize = 65535

function CGetInvitationRewardsList:Ctor(client)
  CGetInvitationRewardsList.super.Ctor(self, client)
end

function CGetInvitationRewardsList:Marshal(buffer)
  return true
end

function CGetInvitationRewardsList:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetInvitationRewardsList

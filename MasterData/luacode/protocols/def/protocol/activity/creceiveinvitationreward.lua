local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveInvitationReward = dataclass("CReceiveInvitationReward", require("framework.net.protocol"))
CReceiveInvitationReward.ProtocolType = 2462
CReceiveInvitationReward.MaxSize = 65535
CReceiveInvitationReward.rewardID = 0

function CReceiveInvitationReward:Ctor(client)
  CReceiveInvitationReward.super.Ctor(self, client)
end

function CReceiveInvitationReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardID) then
    return false
  end
  return true
end

function CReceiveInvitationReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveInvitationReward

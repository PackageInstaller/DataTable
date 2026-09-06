local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveInvitationReward = dataclass("SReceiveInvitationReward", require("framework.net.protocol"))
SReceiveInvitationReward.ProtocolType = 2463
SReceiveInvitationReward.MaxSize = 65535
SReceiveInvitationReward.rewardID = 0
SReceiveInvitationReward.result = 0

function SReceiveInvitationReward:Ctor(client)
  SReceiveInvitationReward.super.Ctor(self, client)
  self.nextReward = require("protocols.bean.protocol.activity.inviteaward").Create()
end

function SReceiveInvitationReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardID) then
    return false
  end
  if not self.nextReward:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SReceiveInvitationReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.nextReward:Unmarshal(buffer) then
    return false
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveInvitationReward

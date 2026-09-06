local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetInvitationRewardsList = dataclass("SGetInvitationRewardsList", require("framework.net.protocol"))
SGetInvitationRewardsList.ProtocolType = 2461
SGetInvitationRewardsList.MaxSize = 65535

function SGetInvitationRewardsList:Ctor(client)
  SGetInvitationRewardsList.super.Ctor(self, client)
  self.rewardsList = {}
end

function SGetInvitationRewardsList:Marshal(buffer)
  local length = table.slen(self.rewardsList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.rewardsList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetInvitationRewardsList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.rewardsList[i] = require("protocols.bean.protocol.activity.inviteaward").Create()
    if not self.rewardsList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetInvitationRewardsList

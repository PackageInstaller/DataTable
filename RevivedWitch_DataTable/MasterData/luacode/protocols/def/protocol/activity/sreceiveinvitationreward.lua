-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceiveinvitationreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveInvitationReward = dataclass("SReceiveInvitationReward", require("framework.net.protocol"))
SReceiveInvitationReward.ProtocolType = 2463
SReceiveInvitationReward.MaxSize = 65535
SReceiveInvitationReward.rewardID = 0
SReceiveInvitationReward.result = 0
SReceiveInvitationReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveInvitationReward, _ENV
  ((SReceiveInvitationReward.super).Ctor)(self, client)
  self.nextReward = ((require("protocols.bean.protocol.activity.inviteaward")).Create)()
end

SReceiveInvitationReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardID) then
    return false
  end
  if not (self.nextReward):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SReceiveInvitationReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.nextReward):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveInvitationReward


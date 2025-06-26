-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceiveinvitationreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveInvitationReward = dataclass("CReceiveInvitationReward", require("framework.net.protocol"))
CReceiveInvitationReward.ProtocolType = 2462
CReceiveInvitationReward.MaxSize = 65535
CReceiveInvitationReward.rewardID = 0
CReceiveInvitationReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveInvitationReward
  ((CReceiveInvitationReward.super).Ctor)(self, client)
end

CReceiveInvitationReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardID) then
    return false
  end
  return true
end

CReceiveInvitationReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveInvitationReward


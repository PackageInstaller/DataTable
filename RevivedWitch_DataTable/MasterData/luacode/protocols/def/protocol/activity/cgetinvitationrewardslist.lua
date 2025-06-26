-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetinvitationrewardslist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetInvitationRewardsList = dataclass("CGetInvitationRewardsList", require("framework.net.protocol"))
CGetInvitationRewardsList.ProtocolType = 2460
CGetInvitationRewardsList.MaxSize = 65535
CGetInvitationRewardsList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetInvitationRewardsList
  ((CGetInvitationRewardsList.super).Ctor)(self, client)
end

CGetInvitationRewardsList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetInvitationRewardsList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetInvitationRewardsList


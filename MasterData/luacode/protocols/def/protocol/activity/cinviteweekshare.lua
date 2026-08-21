-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cinviteweekshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CInviteWeekShare = dataclass("CInviteWeekShare", require("framework.net.protocol"))
CInviteWeekShare.ProtocolType = 2467
CInviteWeekShare.MaxSize = 65535
CInviteWeekShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CInviteWeekShare
  ((CInviteWeekShare.super).Ctor)(self, client)
end

CInviteWeekShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CInviteWeekShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CInviteWeekShare


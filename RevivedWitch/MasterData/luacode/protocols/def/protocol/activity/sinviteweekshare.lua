-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sinviteweekshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SInviteWeekShare = dataclass("SInviteWeekShare", require("framework.net.protocol"))
SInviteWeekShare.ProtocolType = 2468
SInviteWeekShare.MaxSize = 65535
SInviteWeekShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SInviteWeekShare
  ((SInviteWeekShare.super).Ctor)(self, client)
end

SInviteWeekShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SInviteWeekShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SInviteWeekShare


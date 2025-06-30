-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copeninviteshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenInviteShare = dataclass("COpenInviteShare", require("framework.net.protocol"))
COpenInviteShare.ProtocolType = 2465
COpenInviteShare.MaxSize = 65535
COpenInviteShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenInviteShare
  ((COpenInviteShare.super).Ctor)(self, client)
end

COpenInviteShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenInviteShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenInviteShare


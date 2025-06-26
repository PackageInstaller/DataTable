-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenbackinvite.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenBackInvite = dataclass("COpenBackInvite", require("framework.net.protocol"))
COpenBackInvite.ProtocolType = 2549
COpenBackInvite.MaxSize = 65535
COpenBackInvite.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenBackInvite
  ((COpenBackInvite.super).Ctor)(self, client)
end

COpenBackInvite.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenBackInvite.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenBackInvite


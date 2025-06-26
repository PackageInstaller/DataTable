-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crefreshdeeplink.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshDeepLink = dataclass("CRefreshDeepLink", require("framework.net.protocol"))
CRefreshDeepLink.ProtocolType = 2519
CRefreshDeepLink.MaxSize = 65535
CRefreshDeepLink.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshDeepLink
  ((CRefreshDeepLink.super).Ctor)(self, client)
end

CRefreshDeepLink.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshDeepLink.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshDeepLink


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/crefreshrecommendedfriends.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshRecommendedFriends = dataclass("CRefreshRecommendedFriends", require("framework.net.protocol"))
CRefreshRecommendedFriends.ProtocolType = 1120
CRefreshRecommendedFriends.MaxSize = 65535
CRefreshRecommendedFriends.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshRecommendedFriends
  ((CRefreshRecommendedFriends.super).Ctor)(self, client)
end

CRefreshRecommendedFriends.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshRecommendedFriends.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshRecommendedFriends


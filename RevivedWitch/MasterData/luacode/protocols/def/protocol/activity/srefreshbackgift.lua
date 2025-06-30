-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshbackgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshBackGift = dataclass("SRefreshBackGift", require("framework.net.protocol"))
SRefreshBackGift.ProtocolType = 2598
SRefreshBackGift.MaxSize = 65535
SRefreshBackGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshBackGift
  ((SRefreshBackGift.super).Ctor)(self, client)
end

SRefreshBackGift.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SRefreshBackGift.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SRefreshBackGift


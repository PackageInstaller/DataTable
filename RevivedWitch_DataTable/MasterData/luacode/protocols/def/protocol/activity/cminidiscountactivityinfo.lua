-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cminidiscountactivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMiniDiscountActivityInfo = dataclass("CMiniDiscountActivityInfo", require("framework.net.protocol"))
CMiniDiscountActivityInfo.ProtocolType = 2747
CMiniDiscountActivityInfo.MaxSize = 65535
CMiniDiscountActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMiniDiscountActivityInfo
  ((CMiniDiscountActivityInfo.super).Ctor)(self, client)
end

CMiniDiscountActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CMiniDiscountActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CMiniDiscountActivityInfo


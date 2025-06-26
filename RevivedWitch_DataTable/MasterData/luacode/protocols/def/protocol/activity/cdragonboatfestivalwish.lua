-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cdragonboatfestivalwish.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDragonBoatFestivalWish = dataclass("CDragonBoatFestivalWish", require("framework.net.protocol"))
CDragonBoatFestivalWish.ProtocolType = 2654
CDragonBoatFestivalWish.MaxSize = 65535
CDragonBoatFestivalWish.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDragonBoatFestivalWish
  ((CDragonBoatFestivalWish.super).Ctor)(self, client)
end

CDragonBoatFestivalWish.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CDragonBoatFestivalWish.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CDragonBoatFestivalWish


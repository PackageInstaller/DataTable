-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenbackgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenBackGift = dataclass("COpenBackGift", require("framework.net.protocol"))
COpenBackGift.ProtocolType = 2553
COpenBackGift.MaxSize = 65535
COpenBackGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenBackGift
  ((COpenBackGift.super).Ctor)(self, client)
end

COpenBackGift.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenBackGift.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenBackGift


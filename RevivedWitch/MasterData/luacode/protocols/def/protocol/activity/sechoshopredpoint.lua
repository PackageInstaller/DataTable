-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sechoshopredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEchoShopRedPoint = dataclass("SEchoShopRedPoint", require("framework.net.protocol"))
SEchoShopRedPoint.ProtocolType = 2711
SEchoShopRedPoint.MaxSize = 65535
SEchoShopRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEchoShopRedPoint
  ((SEchoShopRedPoint.super).Ctor)(self, client)
end

SEchoShopRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SEchoShopRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SEchoShopRedPoint


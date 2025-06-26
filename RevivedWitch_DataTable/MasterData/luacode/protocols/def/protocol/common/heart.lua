-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/heart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Heart = dataclass("Heart", require("framework.net.protocol"))
Heart.ProtocolType = 100
Heart.MaxSize = 256
Heart.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : Heart
  ((Heart.super).Ctor)(self, client)
end

Heart.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

Heart.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return Heart


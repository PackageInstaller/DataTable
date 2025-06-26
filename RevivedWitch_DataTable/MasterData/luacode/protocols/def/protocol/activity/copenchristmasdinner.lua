-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenchristmasdinner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenChristmasDinner = dataclass("COpenChristmasDinner", require("framework.net.protocol"))
COpenChristmasDinner.ProtocolType = 2530
COpenChristmasDinner.MaxSize = 65536
COpenChristmasDinner.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenChristmasDinner
  ((COpenChristmasDinner.super).Ctor)(self, client)
end

COpenChristmasDinner.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenChristmasDinner.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenChristmasDinner


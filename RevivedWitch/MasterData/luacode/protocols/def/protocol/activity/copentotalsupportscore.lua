-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copentotalsupportscore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenTotalSupportScore = dataclass("COpenTotalSupportScore", require("framework.net.protocol"))
COpenTotalSupportScore.ProtocolType = 2568
COpenTotalSupportScore.MaxSize = 65535
COpenTotalSupportScore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenTotalSupportScore
  ((COpenTotalSupportScore.super).Ctor)(self, client)
end

COpenTotalSupportScore.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenTotalSupportScore.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenTotalSupportScore


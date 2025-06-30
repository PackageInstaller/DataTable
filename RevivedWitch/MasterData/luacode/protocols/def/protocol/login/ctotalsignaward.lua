-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/ctotalsignaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTotalSignAward = dataclass("CTotalSignAward", require("framework.net.protocol"))
CTotalSignAward.ProtocolType = 1072
CTotalSignAward.MaxSize = 65535
CTotalSignAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTotalSignAward
  ((CTotalSignAward.super).Ctor)(self, client)
end

CTotalSignAward.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CTotalSignAward.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CTotalSignAward


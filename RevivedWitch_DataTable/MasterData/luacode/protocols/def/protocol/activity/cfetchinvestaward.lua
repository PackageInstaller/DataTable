-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cfetchinvestaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchInvestAward = dataclass("CFetchInvestAward", require("framework.net.protocol"))
CFetchInvestAward.ProtocolType = 2661
CFetchInvestAward.MaxSize = 65535
CFetchInvestAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchInvestAward
  ((CFetchInvestAward.super).Ctor)(self, client)
end

CFetchInvestAward.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CFetchInvestAward.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CFetchInvestAward


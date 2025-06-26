-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copensummerreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenSummerReward = dataclass("COpenSummerReward", require("framework.net.protocol"))
COpenSummerReward.ProtocolType = 2719
COpenSummerReward.MaxSize = 65535
COpenSummerReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenSummerReward
  ((COpenSummerReward.super).Ctor)(self, client)
end

COpenSummerReward.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenSummerReward.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenSummerReward


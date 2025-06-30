-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/task/mainlinerewardstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local MainLineRewardStatus = dataclass("MainLineRewardStatus")
MainLineRewardStatus.UNFINISHED = 1
MainLineRewardStatus.AVAILABLE = 2
MainLineRewardStatus.RECEIVED = 3
MainLineRewardStatus.Ctor = function(self)
  -- function num : 0_0
end

MainLineRewardStatus.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

MainLineRewardStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return MainLineRewardStatus


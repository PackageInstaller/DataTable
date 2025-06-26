-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/common/commonawardstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CommonAwardStatus = dataclass("CommonAwardStatus")
CommonAwardStatus.LOCKED = 0
CommonAwardStatus.UNLOCKED = 1
CommonAwardStatus.FETCHED = 2
CommonAwardStatus.Ctor = function(self)
  -- function num : 0_0
end

CommonAwardStatus.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CommonAwardStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CommonAwardStatus


local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MainLineRewardStatus = dataclass("MainLineRewardStatus")
MainLineRewardStatus.UNFINISHED = 1
MainLineRewardStatus.AVAILABLE = 2
MainLineRewardStatus.RECEIVED = 3

function MainLineRewardStatus:Ctor()
end

function MainLineRewardStatus:Marshal(buffer)
  return true
end

function MainLineRewardStatus:Unmarshal(buffer)
  local ret = true
  return ret
end

return MainLineRewardStatus

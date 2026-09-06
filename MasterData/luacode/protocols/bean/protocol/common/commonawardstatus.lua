local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CommonAwardStatus = dataclass("CommonAwardStatus")
CommonAwardStatus.LOCKED = 0
CommonAwardStatus.UNLOCKED = 1
CommonAwardStatus.FETCHED = 2

function CommonAwardStatus:Ctor()
end

function CommonAwardStatus:Marshal(buffer)
  return true
end

function CommonAwardStatus:Unmarshal(buffer)
  local ret = true
  return ret
end

return CommonAwardStatus

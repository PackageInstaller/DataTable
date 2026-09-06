local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BuffState = dataclass("BuffState")
BuffState.BUFF_TOUCH = 0
BuffState.BUFF_UNTOUCH = 1

function BuffState:Ctor()
end

function BuffState:Marshal(buffer)
  return true
end

function BuffState:Unmarshal(buffer)
  local ret = true
  return ret
end

return BuffState

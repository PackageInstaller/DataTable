local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendUndecidedRoadRedPoint = dataclass("SSendUndecidedRoadRedPoint", require("framework.net.protocol"))
SSendUndecidedRoadRedPoint.ProtocolType = 2611
SSendUndecidedRoadRedPoint.MaxSize = 65535

function SSendUndecidedRoadRedPoint:Ctor(client)
  SSendUndecidedRoadRedPoint.super.Ctor(self, client)
end

function SSendUndecidedRoadRedPoint:Marshal(buffer)
  return true
end

function SSendUndecidedRoadRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SSendUndecidedRoadRedPoint

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeBuffState = dataclass("CChangeBuffState", require("framework.net.protocol"))
CChangeBuffState.ProtocolType = 4105
CChangeBuffState.MaxSize = 65535
CChangeBuffState.id = 0
CChangeBuffState.status = 0
CChangeBuffState.GETBUFF = 1
CChangeBuffState.LOSEBUFF = 2
CChangeBuffState.PRODUCEBUFF = 3

function CChangeBuffState:Ctor(client)
  CChangeBuffState.super.Ctor(self, client)
end

function CChangeBuffState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  return true
end

function CChangeBuffState:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeBuffState

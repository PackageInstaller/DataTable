local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeBuffState = dataclass("SChangeBuffState", require("framework.net.protocol"))
SChangeBuffState.ProtocolType = 4106
SChangeBuffState.MaxSize = 65535
SChangeBuffState.id = 0
SChangeBuffState.status = 0

function SChangeBuffState:Ctor(client)
  SChangeBuffState.super.Ctor(self, client)
end

function SChangeBuffState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  return true
end

function SChangeBuffState:Unmarshal(buffer)
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

return SChangeBuffState

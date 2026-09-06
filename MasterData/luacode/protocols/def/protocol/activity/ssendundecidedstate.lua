local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendUndecidedState = dataclass("SSendUndecidedState", require("framework.net.protocol"))
SSendUndecidedState.ProtocolType = 2491
SSendUndecidedState.MaxSize = 65535
SSendUndecidedState.state = 0

function SSendUndecidedState:Ctor(client)
  SSendUndecidedState.super.Ctor(self, client)
end

function SSendUndecidedState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SSendUndecidedState:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendUndecidedState

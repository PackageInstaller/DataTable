local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNotifyPosition = dataclass("SNotifyPosition", require("framework.net.protocol"))
SNotifyPosition.ProtocolType = 5015
SNotifyPosition.MaxSize = 65535
SNotifyPosition.userId = 0
SNotifyPosition.position = 0

function SNotifyPosition:Ctor(client)
  SNotifyPosition.super.Ctor(self, client)
end

function SNotifyPosition:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  return true
end

function SNotifyPosition:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SNotifyPosition

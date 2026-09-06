local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenEchoSnack = dataclass("SOpenEchoSnack", require("framework.net.protocol"))
SOpenEchoSnack.ProtocolType = 2709
SOpenEchoSnack.MaxSize = 65535
SOpenEchoSnack.isOpen = 0
SOpenEchoSnack.leftTime = 0
SOpenEchoSnack.waiter = 0
SOpenEchoSnack.snack = 0
SOpenEchoSnack.used = 0

function SOpenEchoSnack:Ctor(client)
  SOpenEchoSnack.super.Ctor(self, client)
end

function SOpenEchoSnack:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isOpen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.waiter) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.snack) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.used) then
    return false
  end
  return true
end

function SOpenEchoSnack:Unmarshal(buffer)
  local ret = true
  ret, self.isOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.waiter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.snack = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.used = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenEchoSnack

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenChristmasDinner = dataclass("SOpenChristmasDinner", require("framework.net.protocol"))
SOpenChristmasDinner.ProtocolType = 2531
SOpenChristmasDinner.MaxSize = 65535
SOpenChristmasDinner.isOpen = 0
SOpenChristmasDinner.leftTime = 0
SOpenChristmasDinner.waiter = 0
SOpenChristmasDinner.snack = 0
SOpenChristmasDinner.used = 0

function SOpenChristmasDinner:Ctor(client)
  SOpenChristmasDinner.super.Ctor(self, client)
end

function SOpenChristmasDinner:Marshal(buffer)
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

function SOpenChristmasDinner:Unmarshal(buffer)
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

return SOpenChristmasDinner

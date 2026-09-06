local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenSnackShop = dataclass("SOpenSnackShop", require("framework.net.protocol"))
SOpenSnackShop.ProtocolType = 2503
SOpenSnackShop.MaxSize = 65535
SOpenSnackShop.isOpen = 0
SOpenSnackShop.leftTime = 0
SOpenSnackShop.waiter = 0
SOpenSnackShop.snack = 0
SOpenSnackShop.used = 0

function SOpenSnackShop:Ctor(client)
  SOpenSnackShop.super.Ctor(self, client)
end

function SOpenSnackShop:Marshal(buffer)
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

function SOpenSnackShop:Unmarshal(buffer)
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

return SOpenSnackShop

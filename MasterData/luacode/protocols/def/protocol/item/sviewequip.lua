local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SViewEquip = dataclass("SViewEquip", require("framework.net.protocol"))
SViewEquip.ProtocolType = 1224
SViewEquip.MaxSize = 65535
SViewEquip.key = 0
SViewEquip.viewDetails = 0

function SViewEquip:Ctor(client)
  SViewEquip.super.Ctor(self, client)
end

function SViewEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.viewDetails) then
    return false
  end
  return true
end

function SViewEquip:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.viewDetails = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SViewEquip

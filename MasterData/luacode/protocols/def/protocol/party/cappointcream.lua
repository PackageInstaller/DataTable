local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAppointCream = dataclass("CAppointCream", require("framework.net.protocol"))
CAppointCream.ProtocolType = 5023
CAppointCream.MaxSize = 65535
CAppointCream.partyId = 0
CAppointCream.userId = 0
CAppointCream.operate = 0

function CAppointCream:Ctor(client)
  CAppointCream.super.Ctor(self, client)
end

function CAppointCream:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  return true
end

function CAppointCream:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAppointCream

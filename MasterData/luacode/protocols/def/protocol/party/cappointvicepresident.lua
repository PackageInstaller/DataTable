local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAppointVicePresident = dataclass("CAppointVicePresident", require("framework.net.protocol"))
CAppointVicePresident.ProtocolType = 5022
CAppointVicePresident.MaxSize = 65535
CAppointVicePresident.partyId = 0
CAppointVicePresident.userId = 0
CAppointVicePresident.operate = 0

function CAppointVicePresident:Ctor(client)
  CAppointVicePresident.super.Ctor(self, client)
end

function CAppointVicePresident:Marshal(buffer)
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

function CAppointVicePresident:Unmarshal(buffer)
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

return CAppointVicePresident

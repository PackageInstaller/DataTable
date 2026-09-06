local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTurnPresident = dataclass("CTurnPresident", require("framework.net.protocol"))
CTurnPresident.ProtocolType = 5021
CTurnPresident.MaxSize = 65535
CTurnPresident.partyId = 0
CTurnPresident.userId = 0

function CTurnPresident:Ctor(client)
  CTurnPresident.super.Ctor(self, client)
end

function CTurnPresident:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CTurnPresident:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTurnPresident

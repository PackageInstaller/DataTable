local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLeiTingAntiAddiction = dataclass("SLeiTingAntiAddiction", require("framework.net.protocol"))
SLeiTingAntiAddiction.ProtocolType = 2265
SLeiTingAntiAddiction.MaxSize = 65535
SLeiTingAntiAddiction.lefttime = 0
SLeiTingAntiAddiction.totaltime = 0
SLeiTingAntiAddiction.isGuest = 0
SLeiTingAntiAddiction.auth = 0
SLeiTingAntiAddiction.AUTH_UNDER_AGE = 0
SLeiTingAntiAddiction.AUTH_ADULT = 1
SLeiTingAntiAddiction.AUTH_UNIDENTIFIED = 2

function SLeiTingAntiAddiction:Ctor(client)
  SLeiTingAntiAddiction.super.Ctor(self, client)
end

function SLeiTingAntiAddiction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lefttime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totaltime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.isGuest) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.auth) then
    return false
  end
  return true
end

function SLeiTingAntiAddiction:Unmarshal(buffer)
  local ret = true
  ret, self.lefttime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totaltime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isGuest = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  ret, self.auth = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLeiTingAntiAddiction

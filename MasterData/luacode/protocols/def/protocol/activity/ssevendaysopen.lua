local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSevenDaysOpen = dataclass("SSevenDaysOpen", require("framework.net.protocol"))
SSevenDaysOpen.ProtocolType = 2435
SSevenDaysOpen.MaxSize = 65535
SSevenDaysOpen.remainTime = 0
SSevenDaysOpen.version = 0
SSevenDaysOpen.OLD_VERSION = 1
SSevenDaysOpen.NEW_VERSION = 2

function SSevenDaysOpen:Ctor(client)
  SSevenDaysOpen.super.Ctor(self, client)
end

function SSevenDaysOpen:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.remainTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.version) then
    return false
  end
  return true
end

function SSevenDaysOpen:Unmarshal(buffer)
  local ret = true
  ret, self.remainTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.version = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenDaysOpen

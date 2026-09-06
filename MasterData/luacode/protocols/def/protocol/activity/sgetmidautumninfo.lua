local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetMidAutumnInfo = dataclass("SGetMidAutumnInfo", require("framework.net.protocol"))
SGetMidAutumnInfo.ProtocolType = 2504
SGetMidAutumnInfo.MaxSize = 65535
SGetMidAutumnInfo.leftTime = 0

function SGetMidAutumnInfo:Ctor(client)
  SGetMidAutumnInfo.super.Ctor(self, client)
end

function SGetMidAutumnInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SGetMidAutumnInfo:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetMidAutumnInfo

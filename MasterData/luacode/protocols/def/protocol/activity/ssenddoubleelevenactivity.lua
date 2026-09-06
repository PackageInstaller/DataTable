local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendDoubleElevenActivity = dataclass("SSendDoubleElevenActivity", require("framework.net.protocol"))
SSendDoubleElevenActivity.ProtocolType = 2520
SSendDoubleElevenActivity.MaxSize = 65535
SSendDoubleElevenActivity.state = 0
SSendDoubleElevenActivity.startTime = 0
SSendDoubleElevenActivity.endTime = 0

function SSendDoubleElevenActivity:Ctor(client)
  SSendDoubleElevenActivity.super.Ctor(self, client)
end

function SSendDoubleElevenActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.startTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  return true
end

function SSendDoubleElevenActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.startTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendDoubleElevenActivity

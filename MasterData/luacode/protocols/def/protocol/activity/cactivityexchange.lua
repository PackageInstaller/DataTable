local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActivityExchange = dataclass("CActivityExchange", require("framework.net.protocol"))
CActivityExchange.ProtocolType = 2505
CActivityExchange.MaxSize = 65535
CActivityExchange.activityId = 0
CActivityExchange.exchangeNum = 0
CActivityExchange.exchangeType = 0
CActivityExchange.EXCHANGE = 1
CActivityExchange.RECYCLE = 2

function CActivityExchange:Ctor(client)
  CActivityExchange.super.Ctor(self, client)
end

function CActivityExchange:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exchangeNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exchangeType) then
    return false
  end
  return true
end

function CActivityExchange:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exchangeNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exchangeType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityExchange

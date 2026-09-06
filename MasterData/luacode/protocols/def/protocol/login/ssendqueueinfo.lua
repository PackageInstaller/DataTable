local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendQueueInfo = dataclass("SSendQueueInfo", require("framework.net.protocol"))
SSendQueueInfo.ProtocolType = 1080
SSendQueueInfo.MaxSize = 65535
SSendQueueInfo.order = 0
SSendQueueInfo.queuelength = 0
SSendQueueInfo.minutes = 0

function SSendQueueInfo:Ctor(client)
  SSendQueueInfo.super.Ctor(self, client)
end

function SSendQueueInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.order) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.queuelength) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.minutes) then
    return false
  end
  return true
end

function SSendQueueInfo:Unmarshal(buffer)
  local ret = true
  ret, self.order = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.queuelength = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.minutes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendQueueInfo

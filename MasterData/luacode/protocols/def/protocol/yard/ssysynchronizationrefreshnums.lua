local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSySynchronizationRefreshNums = dataclass("SSySynchronizationRefreshNums", require("framework.net.protocol"))
SSySynchronizationRefreshNums.ProtocolType = 2331
SSySynchronizationRefreshNums.MaxSize = 65535
SSySynchronizationRefreshNums.nums = 0
SSySynchronizationRefreshNums.leftRefreshTime = 0

function SSySynchronizationRefreshNums:Ctor(client)
  SSySynchronizationRefreshNums.super.Ctor(self, client)
end

function SSySynchronizationRefreshNums:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nums) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftRefreshTime) then
    return false
  end
  return true
end

function SSySynchronizationRefreshNums:Unmarshal(buffer)
  local ret = true
  ret, self.nums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftRefreshTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSySynchronizationRefreshNums

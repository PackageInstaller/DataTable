local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendBeatClownActivity = dataclass("SSendBeatClownActivity", require("framework.net.protocol"))
SSendBeatClownActivity.ProtocolType = 2616
SSendBeatClownActivity.MaxSize = 65535
SSendBeatClownActivity.state = 0
SSendBeatClownActivity.receiveTimes = 0

function SSendBeatClownActivity:Ctor(client)
  SSendBeatClownActivity.super.Ctor(self, client)
end

function SSendBeatClownActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receiveTimes) then
    return false
  end
  return true
end

function SSendBeatClownActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.receiveTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendBeatClownActivity

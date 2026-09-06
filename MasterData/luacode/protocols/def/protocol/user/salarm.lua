local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAlarm = dataclass("SAlarm", require("framework.net.protocol"))
SAlarm.ProtocolType = 2274
SAlarm.MaxSize = 65535
SAlarm.result = 0
SAlarm.SUCCESS = 0
SAlarm.FAIL = 1

function SAlarm:Ctor(client)
  SAlarm.super.Ctor(self, client)
end

function SAlarm:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SAlarm:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAlarm

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateChristmasEvent = dataclass("SUpdateChristmasEvent", require("framework.net.protocol"))
SUpdateChristmasEvent.ProtocolType = 2527
SUpdateChristmasEvent.MaxSize = 65535

function SUpdateChristmasEvent:Ctor(client)
  SUpdateChristmasEvent.super.Ctor(self, client)
  self.updates = {}
end

function SUpdateChristmasEvent:Marshal(buffer)
  local length = table.slen(self.updates)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.updates[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUpdateChristmasEvent:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.updates[i] = require("protocols.bean.protocol.activity.christmasevent").Create()
    if not self.updates[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateChristmasEvent

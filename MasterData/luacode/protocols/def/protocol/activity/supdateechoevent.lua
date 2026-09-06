local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateEchoEvent = dataclass("SUpdateEchoEvent", require("framework.net.protocol"))
SUpdateEchoEvent.ProtocolType = 2705
SUpdateEchoEvent.MaxSize = 65535

function SUpdateEchoEvent:Ctor(client)
  SUpdateEchoEvent.super.Ctor(self, client)
  self.updates = {}
end

function SUpdateEchoEvent:Marshal(buffer)
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

function SUpdateEchoEvent:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.updates[i] = require("protocols.bean.protocol.activity.summerechoevent").Create()
    if not self.updates[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateEchoEvent

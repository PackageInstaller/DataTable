local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateConstructionEvent = dataclass("SUpdateConstructionEvent", require("framework.net.protocol"))
SUpdateConstructionEvent.ProtocolType = 2499
SUpdateConstructionEvent.MaxSize = 65535

function SUpdateConstructionEvent:Ctor(client)
  SUpdateConstructionEvent.super.Ctor(self, client)
  self.updates = {}
  self.updateConstructions = {}
end

function SUpdateConstructionEvent:Marshal(buffer)
  local length = table.slen(self.updates)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.updates[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.updateConstructions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.updateConstructions[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUpdateConstructionEvent:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.updates[i] = require("protocols.bean.protocol.activity.summerevent").Create()
    if not self.updates[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.updateConstructions[i] = require("protocols.bean.protocol.activity.updateconstruction").Create()
    if not self.updateConstructions[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateConstructionEvent

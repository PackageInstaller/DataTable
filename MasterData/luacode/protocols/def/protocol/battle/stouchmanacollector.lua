local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STouchManaCollector = dataclass("STouchManaCollector", require("framework.net.protocol"))
STouchManaCollector.ProtocolType = 1939
STouchManaCollector.MaxSize = 65535
STouchManaCollector.sceneId = 0
STouchManaCollector.key = 0

function STouchManaCollector:Ctor(client)
  STouchManaCollector.super.Ctor(self, client)
  self.manas = {}
end

function STouchManaCollector:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  local length = table.slen(self.manas)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.manas[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function STouchManaCollector:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.manas[i] = require("protocols.bean.protocol.battle.randomitem").Create()
    if not self.manas[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return STouchManaCollector

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFirstPassResourceScene = dataclass("SFirstPassResourceScene", require("framework.net.protocol"))
SFirstPassResourceScene.ProtocolType = 1936
SFirstPassResourceScene.MaxSize = 65535
SFirstPassResourceScene.passid = 0

function SFirstPassResourceScene:Ctor(client)
  SFirstPassResourceScene.super.Ctor(self, client)
  self.firstItems = {}
end

function SFirstPassResourceScene:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.passid) then
    return false
  end
  local length = table.slen(self.firstItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.firstItems[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SFirstPassResourceScene:Unmarshal(buffer)
  local ret = true
  ret, self.passid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.firstItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.firstItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SFirstPassResourceScene

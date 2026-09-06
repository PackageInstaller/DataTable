local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddItem = dataclass("SAddItem", require("framework.net.protocol"))
SAddItem.ProtocolType = 1202
SAddItem.MaxSize = 65535
SAddItem.bagType = 0

function SAddItem:Ctor(client)
  SAddItem.super.Ctor(self, client)
  self.data = {}
end

function SAddItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bagType) then
    return false
  end
  local length = table.slen(self.data)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.data[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SAddItem:Unmarshal(buffer)
  local ret = true
  ret, self.bagType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.data[i] = require("protocols.bean.protocol.item.beans.item").Create()
    if not self.data[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAddItem

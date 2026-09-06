local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDungeonBox = dataclass("SOpenDungeonBox", require("framework.net.protocol"))
SOpenDungeonBox.ProtocolType = 1917
SOpenDungeonBox.MaxSize = 65535
SOpenDungeonBox.boxId = 0

function SOpenDungeonBox:Ctor(client)
  SOpenDungeonBox.super.Ctor(self, client)
  self.items = {}
end

function SOpenDungeonBox:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.boxId) then
    return false
  end
  local length = table.slen(self.items)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.items[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenDungeonBox:Unmarshal(buffer)
  local ret = true
  ret, self.boxId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.items[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.items[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenDungeonBox

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDungeonOption = dataclass("SDungeonOption", require("framework.net.protocol"))
SDungeonOption.ProtocolType = 1927
SDungeonOption.MaxSize = 65535
SDungeonOption.optionId = 0

function SDungeonOption:Ctor(client)
  SDungeonOption.super.Ctor(self, client)
  self.items = {}
end

function SDungeonOption:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.optionId) then
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

function SDungeonOption:Unmarshal(buffer)
  local ret = true
  ret, self.optionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return SDungeonOption

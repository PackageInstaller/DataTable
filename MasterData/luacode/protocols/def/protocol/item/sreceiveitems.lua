local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveItems = dataclass("SReceiveItems", require("framework.net.protocol"))
SReceiveItems.ProtocolType = 1240
SReceiveItems.MaxSize = 65535

function SReceiveItems:Ctor(client)
  SReceiveItems.super.Ctor(self, client)
  self.itemList = {}
end

function SReceiveItems:Marshal(buffer)
  local length = table.slen(self.itemList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SReceiveItems:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemList[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveItems

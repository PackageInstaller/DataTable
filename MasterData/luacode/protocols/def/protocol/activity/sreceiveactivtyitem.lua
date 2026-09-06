local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveActivtyItem = dataclass("SReceiveActivtyItem", require("framework.net.protocol"))
SReceiveActivtyItem.ProtocolType = 2640
SReceiveActivtyItem.MaxSize = 65535
SReceiveActivtyItem.activityLineId = 0
SReceiveActivtyItem.FOOLSDAY = 33

function SReceiveActivtyItem:Ctor(client)
  SReceiveActivtyItem.super.Ctor(self, client)
  self.itemlist = {}
end

function SReceiveActivtyItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityLineId) then
    return false
  end
  local length = table.slen(self.itemlist)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemlist[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SReceiveActivtyItem:Unmarshal(buffer)
  local ret = true
  ret, self.activityLineId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemlist[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemlist[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveActivtyItem

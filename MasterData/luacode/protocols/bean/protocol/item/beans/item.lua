local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Item = dataclass("Item")
Item.id = 0
Item.itemtype = 0
Item.flags = 0
Item.key = 0
Item.position = 0
Item.number = 0
Item.BASEITEM = 1
Item.EQUIP = 2
Item.SKILL = 3
Item.CONSUMAABLE = 4
Item.LOCK = 1

function Item:Ctor()
  self.delTime = {}
  self.extra = require("protocols.bean.protocol.item.beans.equipment").Create()
end

function Item:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.flags) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.number) then
    return false
  end
  local length = table.slen(self.delTime)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.delTime[i]) then
      return false
    end
  end
  if not self.extra:Marshal(buffer) then
    return false
  end
  return true
end

function Item:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.flags = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.number = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.delTime[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  if not self.extra:Unmarshal(buffer) then
    return false
  end
  return ret
end

return Item

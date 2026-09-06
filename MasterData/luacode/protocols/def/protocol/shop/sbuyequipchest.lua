local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBuyEquipChest = dataclass("SBuyEquipChest", require("framework.net.protocol"))
SBuyEquipChest.ProtocolType = 3634
SBuyEquipChest.MaxSize = 65535
SBuyEquipChest.result = 0
SBuyEquipChest.remain = 0

function SBuyEquipChest:Ctor(client)
  SBuyEquipChest.super.Ctor(self, client)
  self.equipments = {}
end

function SBuyEquipChest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.remain) then
    return false
  end
  local length = table.slen(self.equipments)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.equipments[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SBuyEquipChest:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.remain = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.equipments[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.equipments[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SBuyEquipChest

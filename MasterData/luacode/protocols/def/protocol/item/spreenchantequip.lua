local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPreEnchantEquip = dataclass("SPreEnchantEquip", require("framework.net.protocol"))
SPreEnchantEquip.ProtocolType = 1244
SPreEnchantEquip.MaxSize = 65535
SPreEnchantEquip.equipKey = 0
SPreEnchantEquip.leftEnchant = 0
SPreEnchantEquip.stuff = 0
SPreEnchantEquip.luck = 0
SPreEnchantEquip.nextCostMaNa = 0

function SPreEnchantEquip:Ctor(client)
  SPreEnchantEquip.super.Ctor(self, client)
  self.entries = {}
  self.finalAttr = require("protocols.bean.protocol.item.beans.randomentry").Create()
end

function SPreEnchantEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftEnchant) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stuff) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.luck) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nextCostMaNa) then
    return false
  end
  local length = table.slen(self.entries)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.entries[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.finalAttr:Marshal(buffer) then
    return false
  end
  return true
end

function SPreEnchantEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftEnchant = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stuff = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.luck = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.nextCostMaNa = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.entries[i] = require("protocols.bean.protocol.item.beans.randomentry").Create()
    if not self.entries[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.finalAttr:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SPreEnchantEquip

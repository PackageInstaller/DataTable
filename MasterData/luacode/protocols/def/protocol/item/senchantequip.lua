local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnchantEquip = dataclass("SEnchantEquip", require("framework.net.protocol"))
SEnchantEquip.ProtocolType = 1217
SEnchantEquip.MaxSize = 65535
SEnchantEquip.equipKey = 0
SEnchantEquip.kind = 0
SEnchantEquip.luck = 0
SEnchantEquip.power = 0

function SEnchantEquip:Ctor(client)
  SEnchantEquip.super.Ctor(self, client)
  self.randomEntry = {}
  self.finalAttrEntry = require("protocols.bean.protocol.item.beans.randomentry").Create()
  self.finalAttr = {}
end

function SEnchantEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.luck) then
    return false
  end
  local length = table.slen(self.randomEntry)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.randomEntry[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.finalAttrEntry:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.power) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.finalAttr)) then
    return false
  end
  for key, value in pairs(self.finalAttr) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SEnchantEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.luck = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.randomEntry[i] = require("protocols.bean.protocol.item.beans.randomentry").Create()
    if not self.randomEntry[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.finalAttrEntry:Unmarshal(buffer) then
    return false
  end
  ret, self.power = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.finalAttr[key] = value
  end
  return ret
end

return SEnchantEquip

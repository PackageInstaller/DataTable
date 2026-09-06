local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEquipLevelUp = dataclass("SEquipLevelUp", require("framework.net.protocol"))
SEquipLevelUp.ProtocolType = 1222
SEquipLevelUp.MaxSize = 65535
SEquipLevelUp.equipKey = 0
SEquipLevelUp.lv = 0
SEquipLevelUp.exp = 0
SEquipLevelUp.power = 0

function SEquipLevelUp:Ctor(client)
  SEquipLevelUp.super.Ctor(self, client)
  self.finalAttr = {}
end

function SEquipLevelUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exp) then
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

function SEquipLevelUp:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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

return SEquipLevelUp

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeEquipment = dataclass("CChangeEquipment", require("framework.net.protocol"))
CChangeEquipment.ProtocolType = 1210
CChangeEquipment.MaxSize = 65535

function CChangeEquipment:Ctor(client)
  CChangeEquipment.super.Ctor(self, client)
  self.equipToRole = {}
end

function CChangeEquipment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.equipToRole)) then
    return false
  end
  for key, value in pairs(self.equipToRole) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CChangeEquipment:Unmarshal(buffer)
  local ret = true
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
    self.equipToRole[key] = value
  end
  return ret
end

return CChangeEquipment

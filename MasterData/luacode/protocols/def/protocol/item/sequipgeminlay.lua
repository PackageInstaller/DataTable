local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEquipGemInlay = dataclass("SEquipGemInlay", require("framework.net.protocol"))
SEquipGemInlay.ProtocolType = 1274
SEquipGemInlay.MaxSize = 65535
SEquipGemInlay.equipKey = 0
SEquipGemInlay.pos = 0
SEquipGemInlay.gemId = 0
SEquipGemInlay.suitId = 0
SEquipGemInlay.power = 0

function SEquipGemInlay:Ctor(client)
  SEquipGemInlay.super.Ctor(self, client)
  self.finalAttr = {}
end

function SEquipGemInlay:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pos) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.suitId) then
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

function SEquipGemInlay:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.pos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.gemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.suitId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return SEquipGemInlay

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBreakThroughEquip = dataclass("CBreakThroughEquip", require("framework.net.protocol"))
CBreakThroughEquip.ProtocolType = 1241
CBreakThroughEquip.MaxSize = 65535
CBreakThroughEquip.equipKey = 0

function CBreakThroughEquip:Ctor(client)
  CBreakThroughEquip.super.Ctor(self, client)
  self.costEquipKeys = {}
end

function CBreakThroughEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  local length = table.slen(self.costEquipKeys)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.costEquipKeys[i]) then
      return false
    end
  end
  return true
end

function CBreakThroughEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.costEquipKeys[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CBreakThroughEquip

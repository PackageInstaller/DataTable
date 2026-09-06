local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEquipGemInlay = dataclass("CEquipGemInlay", require("framework.net.protocol"))
CEquipGemInlay.ProtocolType = 1273
CEquipGemInlay.MaxSize = 65535
CEquipGemInlay.operate = 0
CEquipGemInlay.equipKey = 0
CEquipGemInlay.pos = 0
CEquipGemInlay.gemId = 0
CEquipGemInlay.INLAY = 1
CEquipGemInlay.REMOVE = 2

function CEquipGemInlay:Ctor(client)
  CEquipGemInlay.super.Ctor(self, client)
end

function CEquipGemInlay:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pos) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gemId) then
    return false
  end
  return true
end

function CEquipGemInlay:Unmarshal(buffer)
  local ret = true
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
  return ret
end

return CEquipGemInlay

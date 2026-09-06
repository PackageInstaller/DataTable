local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEquipExpUp = dataclass("SEquipExpUp", require("framework.net.protocol"))
SEquipExpUp.ProtocolType = 1223
SEquipExpUp.MaxSize = 65535
SEquipExpUp.equipKey = 0
SEquipExpUp.exp = 0

function SEquipExpUp:Ctor(client)
  SEquipExpUp.super.Ctor(self, client)
end

function SEquipExpUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exp) then
    return false
  end
  return true
end

function SEquipExpUp:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SEquipExpUp

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangePreSetEquip = dataclass("CChangePreSetEquip", require("framework.net.protocol"))
CChangePreSetEquip.ProtocolType = 1262
CChangePreSetEquip.MaxSize = 65535
CChangePreSetEquip.roleId = 0
CChangePreSetEquip.equipType = 0
CChangePreSetEquip.equipKey = 0

function CChangePreSetEquip:Ctor(client)
  CChangePreSetEquip.super.Ctor(self, client)
end

function CChangePreSetEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  return true
end

function CChangePreSetEquip:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.equipType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangePreSetEquip

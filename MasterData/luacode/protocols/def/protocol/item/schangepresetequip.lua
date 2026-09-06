local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangePreSetEquip = dataclass("SChangePreSetEquip", require("framework.net.protocol"))
SChangePreSetEquip.ProtocolType = 1263
SChangePreSetEquip.MaxSize = 65535
SChangePreSetEquip.roleId = 0
SChangePreSetEquip.equipType = 0
SChangePreSetEquip.equipKey = 0

function SChangePreSetEquip:Ctor(client)
  SChangePreSetEquip.super.Ctor(self, client)
end

function SChangePreSetEquip:Marshal(buffer)
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

function SChangePreSetEquip:Unmarshal(buffer)
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

return SChangePreSetEquip

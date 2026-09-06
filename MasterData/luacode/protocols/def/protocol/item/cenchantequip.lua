local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnchantEquip = dataclass("CEnchantEquip", require("framework.net.protocol"))
CEnchantEquip.ProtocolType = 1216
CEnchantEquip.MaxSize = 65535
CEnchantEquip.equipKey = 0
CEnchantEquip.stuff = 0

function CEnchantEquip:Ctor(client)
  CEnchantEquip.super.Ctor(self, client)
end

function CEnchantEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stuff) then
    return false
  end
  return true
end

function CEnchantEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stuff = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnchantEquip

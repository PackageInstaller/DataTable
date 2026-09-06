local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSureEnchantEquip = dataclass("CSureEnchantEquip", require("framework.net.protocol"))
CSureEnchantEquip.ProtocolType = 1243
CSureEnchantEquip.MaxSize = 65535
CSureEnchantEquip.equipKey = 0
CSureEnchantEquip.kind = 0
CSureEnchantEquip.SURE = 1
CSureEnchantEquip.CANCEL = 2

function CSureEnchantEquip:Ctor(client)
  CSureEnchantEquip.super.Ctor(self, client)
end

function CSureEnchantEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  return true
end

function CSureEnchantEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSureEnchantEquip

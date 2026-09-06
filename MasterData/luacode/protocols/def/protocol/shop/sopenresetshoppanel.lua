local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenResetShopPanel = dataclass("SOpenResetShopPanel", require("framework.net.protocol"))
SOpenResetShopPanel.ProtocolType = 3625
SOpenResetShopPanel.MaxSize = 65535
SOpenResetShopPanel.shoptype = 0
SOpenResetShopPanel.leftChance = 0
SOpenResetShopPanel.currencyType = 0
SOpenResetShopPanel.nextTimeCost = 0

function SOpenResetShopPanel:Ctor(client)
  SOpenResetShopPanel.super.Ctor(self, client)
end

function SOpenResetShopPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shoptype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftChance) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currencyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nextTimeCost) then
    return false
  end
  return true
end

function SOpenResetShopPanel:Unmarshal(buffer)
  local ret = true
  ret, self.shoptype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftChance = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.currencyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.nextTimeCost = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenResetShopPanel

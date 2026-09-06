local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenResetShopPanel = dataclass("COpenResetShopPanel", require("framework.net.protocol"))
COpenResetShopPanel.ProtocolType = 3624
COpenResetShopPanel.MaxSize = 65535
COpenResetShopPanel.shopType = 0

function COpenResetShopPanel:Ctor(client)
  COpenResetShopPanel.super.Ctor(self, client)
end

function COpenResetShopPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopType) then
    return false
  end
  return true
end

function COpenResetShopPanel:Unmarshal(buffer)
  local ret = true
  ret, self.shopType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenResetShopPanel

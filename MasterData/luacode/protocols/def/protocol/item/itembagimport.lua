local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ItemBagImport = dataclass("ItemBagImport", require("framework.net.protocol"))
ItemBagImport.ProtocolType = 1201
ItemBagImport.MaxSize = 65535

function ItemBagImport:Ctor(client)
  ItemBagImport.super.Ctor(self, client)
  self.b1 = require("protocols.bean.protocol.item.beans.bagtypes").Create()
  self.b2 = require("protocols.bean.protocol.item.equiptype").Create()
end

function ItemBagImport:Marshal(buffer)
  if not self.b1:Marshal(buffer) then
    return false
  end
  if not self.b2:Marshal(buffer) then
    return false
  end
  return true
end

function ItemBagImport:Unmarshal(buffer)
  local ret = true
  if not self.b1:Unmarshal(buffer) then
    return false
  end
  if not self.b2:Unmarshal(buffer) then
    return false
  end
  return ret
end

return ItemBagImport

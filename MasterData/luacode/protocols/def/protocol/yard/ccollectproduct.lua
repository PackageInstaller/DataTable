local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCollectProduct = dataclass("CCollectProduct", require("framework.net.protocol"))
CCollectProduct.ProtocolType = 2320
CCollectProduct.MaxSize = 65535
CCollectProduct.id = 0

function CCollectProduct:Ctor(client)
  CCollectProduct.super.Ctor(self, client)
end

function CCollectProduct:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CCollectProduct:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCollectProduct

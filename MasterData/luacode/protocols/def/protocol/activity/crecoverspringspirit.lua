local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecoverSpringSpirit = dataclass("CRecoverSpringSpirit", require("framework.net.protocol"))
CRecoverSpringSpirit.ProtocolType = 2583
CRecoverSpringSpirit.MaxSize = 65535
CRecoverSpringSpirit.itemId = 0

function CRecoverSpringSpirit:Ctor(client)
  CRecoverSpringSpirit.super.Ctor(self, client)
end

function CRecoverSpringSpirit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  return true
end

function CRecoverSpringSpirit:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverSpringSpirit

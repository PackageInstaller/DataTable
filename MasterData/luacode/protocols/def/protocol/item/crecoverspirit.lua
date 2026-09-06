local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecoverSpirit = dataclass("CRecoverSpirit", require("framework.net.protocol"))
CRecoverSpirit.ProtocolType = 1235
CRecoverSpirit.MaxSize = 65535
CRecoverSpirit.WaitProtocol = "protocol.notify.scancelloading"
CRecoverSpirit.itemId = 0

function CRecoverSpirit:Ctor(client)
  CRecoverSpirit.super.Ctor(self, client)
end

function CRecoverSpirit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  return true
end

function CRecoverSpirit:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverSpirit

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CViewEquip = dataclass("CViewEquip", require("framework.net.protocol"))
CViewEquip.ProtocolType = 1209
CViewEquip.MaxSize = 65535
CViewEquip.key = 0

function CViewEquip:Ctor(client)
  CViewEquip.super.Ctor(self, client)
end

function CViewEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CViewEquip:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CViewEquip

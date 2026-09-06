local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDialogueBuy = dataclass("CDialogueBuy", require("framework.net.protocol"))
CDialogueBuy.ProtocolType = 2604
CDialogueBuy.MaxSize = 65535
CDialogueBuy.id = 0

function CDialogueBuy:Ctor(client)
  CDialogueBuy.super.Ctor(self, client)
end

function CDialogueBuy:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CDialogueBuy:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDialogueBuy

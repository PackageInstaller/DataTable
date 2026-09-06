local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyDiamond = dataclass("CBuyDiamond", require("framework.net.protocol"))
CBuyDiamond.ProtocolType = 3901
CBuyDiamond.MaxSize = 65535
CBuyDiamond.WaitProtocol = "protocol.notify.scancelloading"
CBuyDiamond.goodId = 0

function CBuyDiamond:Ctor(client)
  CBuyDiamond.super.Ctor(self, client)
end

function CBuyDiamond:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function CBuyDiamond:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyDiamond

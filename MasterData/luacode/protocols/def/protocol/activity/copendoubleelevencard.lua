local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenDoubleElevenCard = dataclass("COpenDoubleElevenCard", require("framework.net.protocol"))
COpenDoubleElevenCard.ProtocolType = 2523
COpenDoubleElevenCard.MaxSize = 65535
COpenDoubleElevenCard.poolId = 0
COpenDoubleElevenCard.position = 0

function COpenDoubleElevenCard:Ctor(client)
  COpenDoubleElevenCard.super.Ctor(self, client)
end

function COpenDoubleElevenCard:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.poolId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  return true
end

function COpenDoubleElevenCard:Unmarshal(buffer)
  local ret = true
  ret, self.poolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenDoubleElevenCard

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetHoldPartyConsume = dataclass("SGetHoldPartyConsume", require("framework.net.protocol"))
SGetHoldPartyConsume.ProtocolType = 5028
SGetHoldPartyConsume.MaxSize = 65535
SGetHoldPartyConsume.number = 0

function SGetHoldPartyConsume:Ctor(client)
  SGetHoldPartyConsume.super.Ctor(self, client)
end

function SGetHoldPartyConsume:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.number) then
    return false
  end
  return true
end

function SGetHoldPartyConsume:Unmarshal(buffer)
  local ret = true
  ret, self.number = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetHoldPartyConsume

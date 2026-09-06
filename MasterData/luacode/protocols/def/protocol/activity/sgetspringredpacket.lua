local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSpringRedPacket = dataclass("SGetSpringRedPacket", require("framework.net.protocol"))
SGetSpringRedPacket.ProtocolType = 2577
SGetSpringRedPacket.MaxSize = 65535
SGetSpringRedPacket.redPacketType = 0

function SGetSpringRedPacket:Ctor(client)
  SGetSpringRedPacket.super.Ctor(self, client)
end

function SGetSpringRedPacket:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redPacketType) then
    return false
  end
  return true
end

function SGetSpringRedPacket:Unmarshal(buffer)
  local ret = true
  ret, self.redPacketType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSpringRedPacket

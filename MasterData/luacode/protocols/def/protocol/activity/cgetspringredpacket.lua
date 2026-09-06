local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetSpringRedPacket = dataclass("CGetSpringRedPacket", require("framework.net.protocol"))
CGetSpringRedPacket.ProtocolType = 2576
CGetSpringRedPacket.MaxSize = 65535
CGetSpringRedPacket.redPacketType = 0
CGetSpringRedPacket.FREE = 0
CGetSpringRedPacket.ACTIVE = 1

function CGetSpringRedPacket:Ctor(client)
  CGetSpringRedPacket.super.Ctor(self, client)
end

function CGetSpringRedPacket:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redPacketType) then
    return false
  end
  return true
end

function CGetSpringRedPacket:Unmarshal(buffer)
  local ret = true
  ret, self.redPacketType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetSpringRedPacket

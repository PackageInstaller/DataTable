local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddArenaAP = dataclass("SAddArenaAP", require("framework.net.protocol"))
SAddArenaAP.ProtocolType = 4119
SAddArenaAP.MaxSize = 65535
SAddArenaAP.apAddTimes = 0

function SAddArenaAP:Ctor(client)
  SAddArenaAP.super.Ctor(self, client)
end

function SAddArenaAP:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.apAddTimes) then
    return false
  end
  return true
end

function SAddArenaAP:Unmarshal(buffer)
  local ret = true
  ret, self.apAddTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddArenaAP

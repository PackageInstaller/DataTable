local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CNpcService = dataclass("CNpcService", require("framework.net.protocol"))
CNpcService.ProtocolType = 2003
CNpcService.MaxSize = 65535
CNpcService.npcId = 0
CNpcService.serviceId = 0

function CNpcService:Ctor(client)
  CNpcService.super.Ctor(self, client)
end

function CNpcService:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.npcId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.serviceId) then
    return false
  end
  return true
end

function CNpcService:Unmarshal(buffer)
  local ret = true
  ret, self.npcId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.serviceId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CNpcService

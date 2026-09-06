local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNpcService = dataclass("SNpcService", require("framework.net.protocol"))
SNpcService.ProtocolType = 2004
SNpcService.MaxSize = 65535
SNpcService.npcId = 0
SNpcService.serviceId = 0

function SNpcService:Ctor(client)
  SNpcService.super.Ctor(self, client)
  self.childServiceIds = {}
end

function SNpcService:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.npcId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.serviceId) then
    return false
  end
  local length = table.slen(self.childServiceIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.childServiceIds[i]) then
      return false
    end
  end
  return true
end

function SNpcService:Unmarshal(buffer)
  local ret = true
  ret, self.npcId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.serviceId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.childServiceIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SNpcService

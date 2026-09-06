local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SVisitNpc = dataclass("SVisitNpc", require("framework.net.protocol"))
SVisitNpc.ProtocolType = 2002
SVisitNpc.MaxSize = 65535
SVisitNpc.npcId = 0
SVisitNpc.effectid = 0

function SVisitNpc:Ctor(client)
  SVisitNpc.super.Ctor(self, client)
  self.serviceIds = {}
end

function SVisitNpc:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.npcId) then
    return false
  end
  local length = table.slen(self.serviceIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.serviceIds[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.effectid) then
    return false
  end
  return true
end

function SVisitNpc:Unmarshal(buffer)
  local ret = true
  ret, self.npcId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.serviceIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.effectid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SVisitNpc

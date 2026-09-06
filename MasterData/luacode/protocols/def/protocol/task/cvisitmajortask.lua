local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CVisitMajorTask = dataclass("CVisitMajorTask", require("framework.net.protocol"))
CVisitMajorTask.ProtocolType = 1618
CVisitMajorTask.MaxSize = 65535

function CVisitMajorTask:Ctor(client)
  CVisitMajorTask.super.Ctor(self, client)
  self.taskIds = {}
end

function CVisitMajorTask:Marshal(buffer)
  local length = table.slen(self.taskIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskIds[i]) then
      return false
    end
  end
  return true
end

function CVisitMajorTask:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.taskIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CVisitMajorTask

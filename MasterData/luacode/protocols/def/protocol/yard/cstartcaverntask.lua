local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartCavernTask = dataclass("CStartCavernTask", require("framework.net.protocol"))
CStartCavernTask.ProtocolType = 2318
CStartCavernTask.MaxSize = 65535
CStartCavernTask.id = 0

function CStartCavernTask:Ctor(client)
  CStartCavernTask.super.Ctor(self, client)
  self.roles = {}
end

function CStartCavernTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roles[i]) then
      return false
    end
  end
  return true
end

function CStartCavernTask:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roles[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CStartCavernTask

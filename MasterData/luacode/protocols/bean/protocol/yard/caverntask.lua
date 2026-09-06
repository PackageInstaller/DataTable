local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CavernTask = dataclass("CavernTask")
CavernTask.statue = 0
CavernTask.Id = 0
CavernTask.cavernId = 0
CavernTask.progress = 0
CavernTask.leftReceiveTime = 0
CavernTask.leftDeadline = 0
CavernTask.exploreTimes = 0
CavernTask.LOCK = 0
CavernTask.UNLOCKING = 1
CavernTask.UnReceive = 2
CavernTask.DEADLINE = 3
CavernTask.PROCESSING = 4

function CavernTask:Ctor()
  self.product = {}
  self.roles = {}
end

function CavernTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cavernId) then
    return false
  end
  local length = table.slen(self.product)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.product[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.progress) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftReceiveTime) then
    return false
  end
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.roles[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftDeadline) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.exploreTimes) then
    return false
  end
  return true
end

function CavernTask:Unmarshal(buffer)
  local ret = true
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.Id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.cavernId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.product[i] = require("protocols.bean.protocol.yard.production").Create()
    if not self.product[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.progress = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftReceiveTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.roles[i] = require("protocols.bean.protocol.yard.role").Create()
    if not self.roles[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.leftDeadline = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.exploreTimes = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CavernTask

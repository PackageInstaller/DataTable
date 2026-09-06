local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Task = dataclass("Task")
Task.statue = 0
Task.buildId = 0
Task.buildLvId = 0
Task.progress = 0
Task.leftTime = 0
Task.LOCK = 0
Task.UNLOCK = 1
Task.UnReceive = 2
Task.PROCESSING = 3
Task.UNSTART = 4

function Task:Ctor()
end

function Task:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buildId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buildLvId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.progress) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function Task:Unmarshal(buffer)
  local ret = true
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.buildId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.buildLvId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.progress = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Task

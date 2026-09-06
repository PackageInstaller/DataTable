local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommitTask = dataclass("CCommitTask", require("framework.net.protocol"))
CCommitTask.ProtocolType = 1603
CCommitTask.MaxSize = 65535
CCommitTask.taskid = 0
CCommitTask.agCoinTask = 0

function CCommitTask:Ctor(client)
  CCommitTask.super.Ctor(self, client)
end

function CCommitTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.agCoinTask) then
    return false
  end
  return true
end

function CCommitTask:Unmarshal(buffer)
  local ret = true
  ret, self.taskid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.agCoinTask = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCommitTask

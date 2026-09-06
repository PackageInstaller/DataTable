local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAcceptTask = dataclass("CAcceptTask", require("framework.net.protocol"))
CAcceptTask.ProtocolType = 1601
CAcceptTask.MaxSize = 65535
CAcceptTask.taskid = 0

function CAcceptTask:Ctor(client)
  CAcceptTask.super.Ctor(self, client)
end

function CAcceptTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskid) then
    return false
  end
  return true
end

function CAcceptTask:Unmarshal(buffer)
  local ret = true
  ret, self.taskid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAcceptTask

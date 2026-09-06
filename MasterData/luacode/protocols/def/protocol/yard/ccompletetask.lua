local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCompleteTask = dataclass("CCompleteTask", require("framework.net.protocol"))
CCompleteTask.ProtocolType = 2312
CCompleteTask.MaxSize = 65535
CCompleteTask.id = 0

function CCompleteTask:Ctor(client)
  CCompleteTask.super.Ctor(self, client)
end

function CCompleteTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CCompleteTask:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteTask

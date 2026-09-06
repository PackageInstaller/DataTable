local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartTreeTask = dataclass("CStartTreeTask", require("framework.net.protocol"))
CStartTreeTask.ProtocolType = 2304
CStartTreeTask.MaxSize = 65535
CStartTreeTask.buildId = 0

function CStartTreeTask:Ctor(client)
  CStartTreeTask.super.Ctor(self, client)
end

function CStartTreeTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buildId) then
    return false
  end
  return true
end

function CStartTreeTask:Unmarshal(buffer)
  local ret = true
  ret, self.buildId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTreeTask

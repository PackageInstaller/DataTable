local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshCavernTask = dataclass("CRefreshCavernTask", require("framework.net.protocol"))
CRefreshCavernTask.ProtocolType = 2324
CRefreshCavernTask.MaxSize = 65535
CRefreshCavernTask.id = 0

function CRefreshCavernTask:Ctor(client)
  CRefreshCavernTask.super.Ctor(self, client)
end

function CRefreshCavernTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CRefreshCavernTask:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRefreshCavernTask

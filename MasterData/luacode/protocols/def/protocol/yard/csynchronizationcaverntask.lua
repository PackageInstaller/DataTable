local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSynchronizationCavernTask = dataclass("CSynchronizationCavernTask", require("framework.net.protocol"))
CSynchronizationCavernTask.ProtocolType = 2326
CSynchronizationCavernTask.MaxSize = 65535
CSynchronizationCavernTask.id = 0

function CSynchronizationCavernTask:Ctor(client)
  CSynchronizationCavernTask.super.Ctor(self, client)
end

function CSynchronizationCavernTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CSynchronizationCavernTask:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSynchronizationCavernTask

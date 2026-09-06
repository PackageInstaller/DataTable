local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStrengthTask = dataclass("SStrengthTask", require("framework.net.protocol"))
SStrengthTask.ProtocolType = 2339
SStrengthTask.MaxSize = 65535

function SStrengthTask:Ctor(client)
  SStrengthTask.super.Ctor(self, client)
  self.tasks = {}
end

function SStrengthTask:Marshal(buffer)
  local length = table.slen(self.tasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.tasks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SStrengthTask:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.tasks[i] = require("protocols.bean.protocol.yard.tasktolevel").Create()
    if not self.tasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SStrengthTask

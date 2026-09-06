local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCoinTasks = dataclass("SCoinTasks", require("framework.net.protocol"))
SCoinTasks.ProtocolType = 1628
SCoinTasks.MaxSize = 65535

function SCoinTasks:Ctor(client)
  SCoinTasks.super.Ctor(self, client)
  self.tasks = {}
end

function SCoinTasks:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.tasks)) then
    return false
  end
  for key, value in pairs(self.tasks) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCoinTasks:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.task.taskinfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.tasks[key] = value
  end
  return ret
end

return SCoinTasks

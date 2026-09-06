local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STaskFinishProgress = dataclass("STaskFinishProgress", require("framework.net.protocol"))
STaskFinishProgress.ProtocolType = 2682
STaskFinishProgress.MaxSize = 65535
STaskFinishProgress.firstDrama = 0

function STaskFinishProgress:Ctor(client)
  STaskFinishProgress.super.Ctor(self, client)
  self.tasks = {}
end

function STaskFinishProgress:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstDrama) then
    return false
  end
  return true
end

function STaskFinishProgress:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.activity.taskfinishprogress").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.tasks[key] = value
  end
  ret, self.firstDrama = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STaskFinishProgress

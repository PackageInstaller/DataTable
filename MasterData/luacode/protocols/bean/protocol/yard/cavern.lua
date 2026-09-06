local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Cavern = dataclass("Cavern")
Cavern.level = 0
Cavern.refreshNums = 0
Cavern.leftRefreshTime = 0

function Cavern:Ctor()
  self.tasks = {}
end

function Cavern:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.refreshNums) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftRefreshTime) then
    return false
  end
  return true
end

function Cavern:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
    value = require("protocols.bean.protocol.yard.caverntask").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.tasks[key] = value
  end
  ret, self.refreshNums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftRefreshTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Cavern

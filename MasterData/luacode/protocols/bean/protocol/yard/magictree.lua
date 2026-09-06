local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MagicTree = dataclass("MagicTree")
MagicTree.level = 0
MagicTree.speed = 0

function MagicTree:Ctor()
  self.tasks = {}
end

function MagicTree:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.speed) then
    return false
  end
  return true
end

function MagicTree:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.yard.task").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.tasks[key] = value
  end
  ret, self.speed = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MagicTree

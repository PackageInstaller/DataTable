local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TrainRoom = dataclass("TrainRoom")
TrainRoom.id = 0
TrainRoom.level = 0

function TrainRoom:Ctor()
  self.trainList = {}
end

function TrainRoom:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  local length = table.slen(self.trainList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.trainList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function TrainRoom:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.trainList[i] = require("protocols.bean.protocol.yard.train").Create()
    if not self.trainList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return TrainRoom

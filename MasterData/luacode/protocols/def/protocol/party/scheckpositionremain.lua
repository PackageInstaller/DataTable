local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckPositionRemain = dataclass("SCheckPositionRemain", require("framework.net.protocol"))
SCheckPositionRemain.ProtocolType = 5025
SCheckPositionRemain.MaxSize = 65535

function SCheckPositionRemain:Ctor(client)
  SCheckPositionRemain.super.Ctor(self, client)
  self.positionNumber = {}
end

function SCheckPositionRemain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.positionNumber)) then
    return false
  end
  for key, value in pairs(self.positionNumber) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SCheckPositionRemain:Unmarshal(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.positionNumber[key] = value
  end
  return ret
end

return SCheckPositionRemain

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOldPlayerWelfare = dataclass("SOldPlayerWelfare", require("framework.net.protocol"))
SOldPlayerWelfare.ProtocolType = 2734
SOldPlayerWelfare.MaxSize = 65535
SOldPlayerWelfare.isPay = 0
SOldPlayerWelfare.totalSignNum = 0
SOldPlayerWelfare.endTime = 0

function SOldPlayerWelfare:Ctor(client)
  SOldPlayerWelfare.super.Ctor(self, client)
  self.commonReceiveList = {}
  self.highReceiveList = {}
end

function SOldPlayerWelfare:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isPay) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalSignNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  local length = table.slen(self.commonReceiveList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.commonReceiveList[i]) then
      return false
    end
  end
  local length = table.slen(self.highReceiveList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.highReceiveList[i]) then
      return false
    end
  end
  return true
end

function SOldPlayerWelfare:Unmarshal(buffer)
  local ret = true
  ret, self.isPay = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalSignNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.commonReceiveList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.highReceiveList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SOldPlayerWelfare

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenFoolsDayActivity = dataclass("SOpenFoolsDayActivity", require("framework.net.protocol"))
SOpenFoolsDayActivity.ProtocolType = 2623
SOpenFoolsDayActivity.MaxSize = 65535
SOpenFoolsDayActivity.state = 0
SOpenFoolsDayActivity.endTime = 0
SOpenFoolsDayActivity.floorId = 0
SOpenFoolsDayActivity.floorState = 0
SOpenFoolsDayActivity.resetConfigId = 0
SOpenFoolsDayActivity.closeOthers = 0

function SOpenFoolsDayActivity:Ctor(client)
  SOpenFoolsDayActivity.super.Ctor(self, client)
  self.functionId = {}
end

function SOpenFoolsDayActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorState) then
    return false
  end
  local length = table.slen(self.functionId)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.functionId[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resetConfigId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.closeOthers) then
    return false
  end
  return true
end

function SOpenFoolsDayActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.floorState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.functionId[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.resetConfigId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.closeOthers = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenFoolsDayActivity

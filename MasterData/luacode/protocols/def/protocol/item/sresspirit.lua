local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SResSpirit = dataclass("SResSpirit", require("framework.net.protocol"))
SResSpirit.ProtocolType = 1234
SResSpirit.MaxSize = 65535
SResSpirit.spirit = 0
SResSpirit.strengthLimit = 0
SResSpirit.leftTime = 0

function SResSpirit:Ctor(client)
  SResSpirit.super.Ctor(self, client)
  self.recoverTimes = {}
end

function SResSpirit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spirit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.strengthLimit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.recoverTimes)) then
    return false
  end
  for key, value in pairs(self.recoverTimes) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SResSpirit:Unmarshal(buffer)
  local ret = true
  ret, self.spirit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.strengthLimit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.recoverTimes[key] = value
  end
  return ret
end

return SResSpirit

local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetBuffInfo = dataclass("SGetBuffInfo", require("framework.net.protocol"))
SGetBuffInfo.ProtocolType = 2532
SGetBuffInfo.MaxSize = 65535

function SGetBuffInfo:Ctor(client)
  SGetBuffInfo.super.Ctor(self, client)
  self.buffIds = {}
end

function SGetBuffInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.buffIds)) then
    return false
  end
  for key, value in pairs(self.buffIds) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetBuffInfo:Unmarshal(buffer)
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
    self.buffIds[key] = value
  end
  return ret
end

return SGetBuffInfo

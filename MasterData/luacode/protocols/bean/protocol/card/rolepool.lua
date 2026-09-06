local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local RolePool = dataclass("RolePool")
RolePool.rate = 0

function RolePool:Ctor()
  self.ids = {}
end

function RolePool:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rate) then
    return false
  end
  local length = table.slen(self.ids)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ids[i]) then
      return false
    end
  end
  return true
end

function RolePool:Unmarshal(buffer)
  local ret = true
  ret, self.rate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.ids[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return RolePool

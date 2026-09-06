local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleUpdateFavorLv = dataclass("SRoleUpdateFavorLv", require("framework.net.protocol"))
SRoleUpdateFavorLv.ProtocolType = 1019
SRoleUpdateFavorLv.MaxSize = 65535
SRoleUpdateFavorLv.id = 0
SRoleUpdateFavorLv.favorLv = 0
SRoleUpdateFavorLv.exp = 0

function SRoleUpdateFavorLv:Ctor(client)
  SRoleUpdateFavorLv.super.Ctor(self, client)
  self.favorAwardStatus = {}
end

function SRoleUpdateFavorLv:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.favorLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.exp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.favorAwardStatus)) then
    return false
  end
  for key, value in pairs(self.favorAwardStatus) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SRoleUpdateFavorLv:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.favorLv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.exp = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    self.favorAwardStatus[key] = value
  end
  return ret
end

return SRoleUpdateFavorLv

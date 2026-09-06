local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenRoleIcon = dataclass("SOpenRoleIcon", require("framework.net.protocol"))
SOpenRoleIcon.ProtocolType = 2593
SOpenRoleIcon.MaxSize = 65535
SOpenRoleIcon.roleNum = 0
SOpenRoleIcon.isMask = 0

function SOpenRoleIcon:Ctor(client)
  SOpenRoleIcon.super.Ctor(self, client)
  self.roleMap = {}
  self.progressReward = {}
end

function SOpenRoleIcon:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleMap)) then
    return false
  end
  for key, value in pairs(self.roleMap) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.progressReward)) then
    return false
  end
  for key, value in pairs(self.progressReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.isMask) then
    return false
  end
  return true
end

function SOpenRoleIcon:Unmarshal(buffer)
  local ret = true
  ret, self.roleNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.roleMap[key] = value
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
    self.progressReward[key] = value
  end
  ret, self.isMask = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenRoleIcon

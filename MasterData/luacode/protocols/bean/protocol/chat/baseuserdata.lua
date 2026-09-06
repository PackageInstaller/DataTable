local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BaseUserData = dataclass("BaseUserData")
BaseUserData.userId = 0
BaseUserData.userName = ""
BaseUserData.avatarId = 0
BaseUserData.frameId = 0
BaseUserData.panelFrame = 0
BaseUserData.userLv = 0
BaseUserData.spiritvip = 0
BaseUserData.iplocaladdr = ""

function BaseUserData:Ctor()
  self.showBadges = {}
end

function BaseUserData:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.userName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.panelFrame) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userLv) then
    return false
  end
  local length = table.slen(self.showBadges)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.showBadges[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spiritvip) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.iplocaladdr) then
    return false
  end
  return true
end

function BaseUserData:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.panelFrame = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.userLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.showBadges[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.spiritvip = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.iplocaladdr = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BaseUserData

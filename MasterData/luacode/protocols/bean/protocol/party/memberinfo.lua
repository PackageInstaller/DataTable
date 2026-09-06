local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MemberInfo = dataclass("MemberInfo")
MemberInfo.userId = 0
MemberInfo.username = ""
MemberInfo.userLevel = 0
MemberInfo.avatarId = 0
MemberInfo.frameId = 0
MemberInfo.applyTime = 0
MemberInfo.lastTime = 0
MemberInfo.position = 0
MemberInfo.identity = 0
MemberInfo.donate = 0
MemberInfo.spiritvip = 0
MemberInfo.RESIGN = -1
MemberInfo.PRESIDENT = 1
MemberInfo.VICE_PRESIDENT = 2
MemberInfo.CREAM = 3
MemberInfo.MEMBER = 4
MemberInfo.OFFLINE = 0
MemberInfo.ONLINE = 1

function MemberInfo:Ctor()
end

function MemberInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.username) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.applyTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.lastTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.identity) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.donate) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spiritvip) then
    return false
  end
  return true
end

function MemberInfo:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.username = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.userLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.applyTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.lastTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.identity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.donate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.spiritvip = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MemberInfo
